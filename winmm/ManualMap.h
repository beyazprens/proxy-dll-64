#ifndef MANUALMAP_H
#define MANUALMAP_H

#include <windows.h>

// Manually maps a DLL file into the current process without registering it
// in the Windows loader's module list (PEB LDR data).
//
// The loaded DLL will be invisible to:
//   - EnumProcessModules / Module32First / Module32Next
//   - GetModuleHandle
//   - PEB->Ldr InLoadOrderModuleList traversal (used by anti-cheat systems)
//
// Stealth measures applied:
//   - No PEB module list entry (inherent in manual map)
//   - PE headers erased after mapping (prevents MZ/PE signature scanning)
//   - Per-section page protections applied (no suspicious all-RWX region)
//   - x64 exception directory registered via RtlAddFunctionTable
//   - TLS callbacks executed before DllMain
//
// Returns the base address of the mapped image cast to HMODULE, or NULL on failure.
HMODULE ManualMap(LPCSTR lpFilePath);

#endif
