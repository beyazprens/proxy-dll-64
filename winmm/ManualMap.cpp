#include "ManualMap.h"
#include <string.h>

typedef BOOL (WINAPI *DLL_ENTRY_POINT)(HINSTANCE, DWORD, LPVOID);

// Convert PE section characteristics flags to VirtualProtect page protection.
static DWORD GetSectionProtection(DWORD characteristics)
{
    if (characteristics & IMAGE_SCN_MEM_EXECUTE)
    {
        if (characteristics & IMAGE_SCN_MEM_WRITE)
            return PAGE_EXECUTE_READWRITE;
        if (characteristics & IMAGE_SCN_MEM_READ)
            return PAGE_EXECUTE_READ;
        return PAGE_EXECUTE;
    }
    if (characteristics & IMAGE_SCN_MEM_WRITE)
        return PAGE_READWRITE;
    if (characteristics & IMAGE_SCN_MEM_READ)
        return PAGE_READONLY;
    return PAGE_NOACCESS;
}

// Resolve the import directory of the mapped image using LoadLibraryA /
// GetProcAddress.  System DLLs (kernel32, user32, etc.) are already loaded
// in the process; this just connects the IAT pointers.
static void ResolveImports(BYTE *pBase, PIMAGE_NT_HEADERS64 pNT)
{
    PIMAGE_DATA_DIRECTORY pImportDir =
        &pNT->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_IMPORT];
    if (!pImportDir->Size)
        return;

    PIMAGE_IMPORT_DESCRIPTOR pImport =
        (PIMAGE_IMPORT_DESCRIPTOR)(pBase + pImportDir->VirtualAddress);

    while (pImport->Name)
    {
        char *modName = (char *)(pBase + pImport->Name);
        HMODULE hMod  = LoadLibraryA(modName);
        if (hMod)
        {
            PIMAGE_THUNK_DATA64 pThunk =
                (PIMAGE_THUNK_DATA64)(pBase + pImport->FirstThunk);
            PIMAGE_THUNK_DATA64 pOrig =
                pImport->OriginalFirstThunk
                    ? (PIMAGE_THUNK_DATA64)(pBase + pImport->OriginalFirstThunk)
                    : pThunk;

            while (pOrig->u1.AddressOfData)
            {
                FARPROC proc = NULL;
                if (IMAGE_SNAP_BY_ORDINAL64(pOrig->u1.Ordinal))
                    proc = GetProcAddress(hMod,
                        MAKEINTRESOURCEA(IMAGE_ORDINAL64(pOrig->u1.Ordinal)));
                else
                    proc = GetProcAddress(hMod,
                        ((PIMAGE_IMPORT_BY_NAME)(pBase + pOrig->u1.AddressOfData))->Name);

                pThunk->u1.Function = (ULONGLONG)proc;
                pThunk++;
                pOrig++;
            }
        }
        pImport++;
    }
}

HMODULE ManualMap(LPCSTR lpFilePath)
{
    // ── 1. Read the raw DLL file ───────────────────────────────────────────
    HANDLE hFile = CreateFileA(lpFilePath, GENERIC_READ, FILE_SHARE_READ,
                               NULL, OPEN_EXISTING, 0, NULL);
    if (hFile == INVALID_HANDLE_VALUE)
        return NULL;

    DWORD fileSize = GetFileSize(hFile, NULL);
    if (fileSize == INVALID_FILE_SIZE || fileSize < sizeof(IMAGE_DOS_HEADER))
    {
        CloseHandle(hFile);
        return NULL;
    }

    BYTE *pFileBuffer = (BYTE *)VirtualAlloc(NULL, fileSize,
                                             MEM_COMMIT | MEM_RESERVE,
                                             PAGE_READWRITE);
    if (!pFileBuffer)
    {
        CloseHandle(hFile);
        return NULL;
    }

    DWORD bytesRead = 0;
    BOOL  readOk    = ReadFile(hFile, pFileBuffer, fileSize, &bytesRead, NULL);
    CloseHandle(hFile);

    if (!readOk || bytesRead != fileSize)
    {
        VirtualFree(pFileBuffer, 0, MEM_RELEASE);
        return NULL;
    }

    // ── 2. Validate PE headers ────────────────────────────────────────────
    PIMAGE_DOS_HEADER pDOS = (PIMAGE_DOS_HEADER)pFileBuffer;
    if (pDOS->e_magic != IMAGE_DOS_SIGNATURE)
    {
        VirtualFree(pFileBuffer, 0, MEM_RELEASE);
        return NULL;
    }

    PIMAGE_NT_HEADERS64 pNT =
        (PIMAGE_NT_HEADERS64)(pFileBuffer + pDOS->e_lfanew);

    if (pNT->Signature != IMAGE_NT_SIGNATURE               ||
        pNT->FileHeader.Machine != IMAGE_FILE_MACHINE_AMD64 ||
        !(pNT->FileHeader.Characteristics & IMAGE_FILE_DLL))
    {
        VirtualFree(pFileBuffer, 0, MEM_RELEASE);
        return NULL;
    }

    // ── 3. Allocate virtual memory for the mapped image ───────────────────
    // Try preferred base first; fall back to any available address.
    BYTE *pBase = (BYTE *)VirtualAlloc(
        (LPVOID)pNT->OptionalHeader.ImageBase,
        pNT->OptionalHeader.SizeOfImage,
        MEM_RESERVE | MEM_COMMIT,
        PAGE_EXECUTE_READWRITE);

    if (!pBase)
        pBase = (BYTE *)VirtualAlloc(NULL,
            pNT->OptionalHeader.SizeOfImage,
            MEM_RESERVE | MEM_COMMIT,
            PAGE_EXECUTE_READWRITE);

    if (!pBase)
    {
        VirtualFree(pFileBuffer, 0, MEM_RELEASE);
        return NULL;
    }

    // ── 4. Copy PE headers ────────────────────────────────────────────────
    memcpy(pBase, pFileBuffer, pNT->OptionalHeader.SizeOfHeaders);

    // ── 5. Copy sections ──────────────────────────────────────────────────
    PIMAGE_SECTION_HEADER pSection = IMAGE_FIRST_SECTION(pNT);
    for (WORD i = 0; i < pNT->FileHeader.NumberOfSections; i++, pSection++)
    {
        if (pSection->SizeOfRawData && pSection->PointerToRawData)
        {
            memcpy(pBase + pSection->VirtualAddress,
                   pFileBuffer + pSection->PointerToRawData,
                   pSection->SizeOfRawData);
        }
    }

    // Work through the NT headers in the mapped image from here on.
    PIMAGE_NT_HEADERS64 pNTM =
        (PIMAGE_NT_HEADERS64)(pBase + pDOS->e_lfanew);

    // ── 6. Apply base relocations (if loaded at a different address) ──────
    ULONGLONG delta = (ULONGLONG)pBase - pNT->OptionalHeader.ImageBase;
    if (delta != 0)
    {
        PIMAGE_DATA_DIRECTORY pRelocDir =
            &pNTM->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_BASERELOC];
        if (pRelocDir->Size)
        {
            PIMAGE_BASE_RELOCATION pReloc =
                (PIMAGE_BASE_RELOCATION)(pBase + pRelocDir->VirtualAddress);

            while (pReloc->VirtualAddress &&
                   pReloc->SizeOfBlock >= sizeof(IMAGE_BASE_RELOCATION))
            {
                DWORD count = (pReloc->SizeOfBlock -
                               sizeof(IMAGE_BASE_RELOCATION)) / sizeof(WORD);
                WORD *pEntry = (WORD *)((BYTE *)pReloc +
                                        sizeof(IMAGE_BASE_RELOCATION));

                for (DWORD j = 0; j < count; j++)
                {
                    if ((pEntry[j] >> 12) == IMAGE_REL_BASED_DIR64)
                    {
                        ULONGLONG *pPatch = (ULONGLONG *)(pBase +
                            pReloc->VirtualAddress + (pEntry[j] & 0xFFF));
                        *pPatch += delta;
                    }
                }
                pReloc = (PIMAGE_BASE_RELOCATION)(
                    (BYTE *)pReloc + pReloc->SizeOfBlock);
            }
        }
    }

    // ── 7. Resolve imports ────────────────────────────────────────────────
    ResolveImports(pBase, pNTM);

    // ── 8. Register x64 exception directory so SEH works inside the DLL ──
    PIMAGE_DATA_DIRECTORY pExceptDir =
        &pNTM->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_EXCEPTION];
    if (pExceptDir->Size)
    {
        RtlAddFunctionTable(
            (PRUNTIME_FUNCTION)(pBase + pExceptDir->VirtualAddress),
            pExceptDir->Size / sizeof(RUNTIME_FUNCTION),
            (DWORD64)pBase);
    }

    // ── 9. Execute TLS callbacks ──────────────────────────────────────────
    PIMAGE_DATA_DIRECTORY pTLSDir =
        &pNTM->OptionalHeader.DataDirectory[IMAGE_DIRECTORY_ENTRY_TLS];
    if (pTLSDir->Size)
    {
        PIMAGE_TLS_DIRECTORY64 pTLS =
            (PIMAGE_TLS_DIRECTORY64)(pBase + pTLSDir->VirtualAddress);
        PIMAGE_TLS_CALLBACK *pCallback =
            (PIMAGE_TLS_CALLBACK *)pTLS->AddressOfCallBacks;
        if (pCallback)
        {
            while (*pCallback)
            {
                (*pCallback)((HINSTANCE)pBase, DLL_PROCESS_ATTACH, NULL);
                pCallback++;
            }
        }
    }

    // ── 10. Apply correct per-section page protections ────────────────────
    // Leaving every page as PAGE_EXECUTE_READWRITE is a red flag for anti-
    // cheat scanners.  Set proper permissions matching section flags.
    pSection = IMAGE_FIRST_SECTION(pNTM);
    for (WORD i = 0; i < pNTM->FileHeader.NumberOfSections; i++, pSection++)
    {
        if (!pSection->VirtualAddress || !pSection->Misc.VirtualSize)
            continue;
        DWORD protect   = GetSectionProtection(pSection->Characteristics);
        DWORD oldProtect = 0;
        VirtualProtect(pBase + pSection->VirtualAddress,
                       pSection->Misc.VirtualSize,
                       protect, &oldProtect);
    }

    // ── 11. Call DllMain ──────────────────────────────────────────────────
    if (pNTM->OptionalHeader.AddressOfEntryPoint)
    {
        DLL_ENTRY_POINT dllMain = (DLL_ENTRY_POINT)(
            pBase + pNTM->OptionalHeader.AddressOfEntryPoint);
        if (!dllMain((HINSTANCE)pBase, DLL_PROCESS_ATTACH, NULL))
        {
            // DllMain returned FALSE — the DLL refused to initialise.
            VirtualFree(pBase, 0, MEM_RELEASE);
            VirtualFree(pFileBuffer, 0, MEM_RELEASE);
            return NULL;
        }
    }

    // ── 12. Erase PE headers for maximum stealth ──────────────────────────
    // Zeroing the MZ/PE headers prevents signature-based memory scanners
    // from identifying this allocation as a loaded PE image.
    DWORD headerSize = pNTM->OptionalHeader.SizeOfHeaders;
    DWORD oldProtect = 0;
    VirtualProtect(pBase, headerSize, PAGE_READWRITE, &oldProtect);
    memset(pBase, 0, headerSize);
    VirtualProtect(pBase, headerSize, PAGE_NOACCESS, &oldProtect);

    // ── 13. Free the raw file buffer ──────────────────────────────────────
    VirtualFree(pFileBuffer, 0, MEM_RELEASE);

    return (HMODULE)pBase;
}
