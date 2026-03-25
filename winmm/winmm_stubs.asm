; winmm_stubs.asm - MASM x64 jump stubs for Visual Studio builds
; Each stub forwards to the corresponding system winmm.dll function
; via the global function-pointer array 'p' defined in main.cpp.

EXTRN p:BYTE

.code

CloseDriver PROC
    mov rax, QWORD PTR p[0*8]
    jmp rax
CloseDriver ENDP

DefDriverProc PROC
    mov rax, QWORD PTR p[1*8]
    jmp rax
DefDriverProc ENDP

DriverCallback PROC
    mov rax, QWORD PTR p[2*8]
    jmp rax
DriverCallback ENDP

DrvGetModuleHandle PROC
    mov rax, QWORD PTR p[3*8]
    jmp rax
DrvGetModuleHandle ENDP

GetDriverModuleHandle PROC
    mov rax, QWORD PTR p[4*8]
    jmp rax
GetDriverModuleHandle ENDP

OpenDriver PROC
    mov rax, QWORD PTR p[5*8]
    jmp rax
OpenDriver ENDP

PlaySound PROC
    mov rax, QWORD PTR p[6*8]
    jmp rax
PlaySound ENDP

PlaySoundA PROC
    mov rax, QWORD PTR p[7*8]
    jmp rax
PlaySoundA ENDP

PlaySoundW PROC
    mov rax, QWORD PTR p[8*8]
    jmp rax
PlaySoundW ENDP

SendDriverMessage PROC
    mov rax, QWORD PTR p[9*8]
    jmp rax
SendDriverMessage ENDP

WOWAppExit PROC
    mov rax, QWORD PTR p[10*8]
    jmp rax
WOWAppExit ENDP

auxGetDevCapsA PROC
    mov rax, QWORD PTR p[11*8]
    jmp rax
auxGetDevCapsA ENDP

auxGetDevCapsW PROC
    mov rax, QWORD PTR p[12*8]
    jmp rax
auxGetDevCapsW ENDP

auxGetNumDevs PROC
    mov rax, QWORD PTR p[13*8]
    jmp rax
auxGetNumDevs ENDP

auxGetVolume PROC
    mov rax, QWORD PTR p[14*8]
    jmp rax
auxGetVolume ENDP

auxOutMessage PROC
    mov rax, QWORD PTR p[15*8]
    jmp rax
auxOutMessage ENDP

auxSetVolume PROC
    mov rax, QWORD PTR p[16*8]
    jmp rax
auxSetVolume ENDP

joyConfigChanged PROC
    mov rax, QWORD PTR p[17*8]
    jmp rax
joyConfigChanged ENDP

joyGetDevCapsA PROC
    mov rax, QWORD PTR p[18*8]
    jmp rax
joyGetDevCapsA ENDP

joyGetDevCapsW PROC
    mov rax, QWORD PTR p[19*8]
    jmp rax
joyGetDevCapsW ENDP

joyGetNumDevs PROC
    mov rax, QWORD PTR p[20*8]
    jmp rax
joyGetNumDevs ENDP

joyGetPos PROC
    mov rax, QWORD PTR p[21*8]
    jmp rax
joyGetPos ENDP

joyGetPosEx PROC
    mov rax, QWORD PTR p[22*8]
    jmp rax
joyGetPosEx ENDP

joyGetThreshold PROC
    mov rax, QWORD PTR p[23*8]
    jmp rax
joyGetThreshold ENDP

joyReleaseCapture PROC
    mov rax, QWORD PTR p[24*8]
    jmp rax
joyReleaseCapture ENDP

joySetCapture PROC
    mov rax, QWORD PTR p[25*8]
    jmp rax
joySetCapture ENDP

joySetThreshold PROC
    mov rax, QWORD PTR p[26*8]
    jmp rax
joySetThreshold ENDP

mciDriverNotify PROC
    mov rax, QWORD PTR p[27*8]
    jmp rax
mciDriverNotify ENDP

mciDriverYield PROC
    mov rax, QWORD PTR p[28*8]
    jmp rax
mciDriverYield ENDP

mciExecute PROC
    mov rax, QWORD PTR p[29*8]
    jmp rax
mciExecute ENDP

mciFreeCommandResource PROC
    mov rax, QWORD PTR p[30*8]
    jmp rax
mciFreeCommandResource ENDP

mciGetCreatorTask PROC
    mov rax, QWORD PTR p[31*8]
    jmp rax
mciGetCreatorTask ENDP

mciGetDeviceIDA PROC
    mov rax, QWORD PTR p[32*8]
    jmp rax
mciGetDeviceIDA ENDP

mciGetDeviceIDFromElementIDA PROC
    mov rax, QWORD PTR p[33*8]
    jmp rax
mciGetDeviceIDFromElementIDA ENDP

mciGetDeviceIDFromElementIDW PROC
    mov rax, QWORD PTR p[34*8]
    jmp rax
mciGetDeviceIDFromElementIDW ENDP

mciGetDeviceIDW PROC
    mov rax, QWORD PTR p[35*8]
    jmp rax
mciGetDeviceIDW ENDP

mciGetDriverData PROC
    mov rax, QWORD PTR p[36*8]
    jmp rax
mciGetDriverData ENDP

mciGetErrorStringA PROC
    mov rax, QWORD PTR p[37*8]
    jmp rax
mciGetErrorStringA ENDP

mciGetErrorStringW PROC
    mov rax, QWORD PTR p[38*8]
    jmp rax
mciGetErrorStringW ENDP

mciGetYieldProc PROC
    mov rax, QWORD PTR p[39*8]
    jmp rax
mciGetYieldProc ENDP

mciLoadCommandResource PROC
    mov rax, QWORD PTR p[40*8]
    jmp rax
mciLoadCommandResource ENDP

mciSendCommandA PROC
    mov rax, QWORD PTR p[41*8]
    jmp rax
mciSendCommandA ENDP

mciSendCommandW PROC
    mov rax, QWORD PTR p[42*8]
    jmp rax
mciSendCommandW ENDP

mciSendStringA PROC
    mov rax, QWORD PTR p[43*8]
    jmp rax
mciSendStringA ENDP

mciSendStringW PROC
    mov rax, QWORD PTR p[44*8]
    jmp rax
mciSendStringW ENDP

mciSetDriverData PROC
    mov rax, QWORD PTR p[45*8]
    jmp rax
mciSetDriverData ENDP

mciSetYieldProc PROC
    mov rax, QWORD PTR p[46*8]
    jmp rax
mciSetYieldProc ENDP

midiConnect PROC
    mov rax, QWORD PTR p[47*8]
    jmp rax
midiConnect ENDP

midiDisconnect PROC
    mov rax, QWORD PTR p[48*8]
    jmp rax
midiDisconnect ENDP

midiInAddBuffer PROC
    mov rax, QWORD PTR p[49*8]
    jmp rax
midiInAddBuffer ENDP

midiInClose PROC
    mov rax, QWORD PTR p[50*8]
    jmp rax
midiInClose ENDP

midiInGetDevCapsA PROC
    mov rax, QWORD PTR p[51*8]
    jmp rax
midiInGetDevCapsA ENDP

midiInGetDevCapsW PROC
    mov rax, QWORD PTR p[52*8]
    jmp rax
midiInGetDevCapsW ENDP

midiInGetErrorTextA PROC
    mov rax, QWORD PTR p[53*8]
    jmp rax
midiInGetErrorTextA ENDP

midiInGetErrorTextW PROC
    mov rax, QWORD PTR p[54*8]
    jmp rax
midiInGetErrorTextW ENDP

midiInGetID PROC
    mov rax, QWORD PTR p[55*8]
    jmp rax
midiInGetID ENDP

midiInGetNumDevs PROC
    mov rax, QWORD PTR p[56*8]
    jmp rax
midiInGetNumDevs ENDP

midiInMessage PROC
    mov rax, QWORD PTR p[57*8]
    jmp rax
midiInMessage ENDP

midiInOpen PROC
    mov rax, QWORD PTR p[58*8]
    jmp rax
midiInOpen ENDP

midiInPrepareHeader PROC
    mov rax, QWORD PTR p[59*8]
    jmp rax
midiInPrepareHeader ENDP

midiInReset PROC
    mov rax, QWORD PTR p[60*8]
    jmp rax
midiInReset ENDP

midiInStart PROC
    mov rax, QWORD PTR p[61*8]
    jmp rax
midiInStart ENDP

midiInStop PROC
    mov rax, QWORD PTR p[62*8]
    jmp rax
midiInStop ENDP

midiInUnprepareHeader PROC
    mov rax, QWORD PTR p[63*8]
    jmp rax
midiInUnprepareHeader ENDP

midiOutCacheDrumPatches PROC
    mov rax, QWORD PTR p[64*8]
    jmp rax
midiOutCacheDrumPatches ENDP

midiOutCachePatches PROC
    mov rax, QWORD PTR p[65*8]
    jmp rax
midiOutCachePatches ENDP

midiOutClose PROC
    mov rax, QWORD PTR p[66*8]
    jmp rax
midiOutClose ENDP

midiOutGetDevCapsA PROC
    mov rax, QWORD PTR p[67*8]
    jmp rax
midiOutGetDevCapsA ENDP

midiOutGetDevCapsW PROC
    mov rax, QWORD PTR p[68*8]
    jmp rax
midiOutGetDevCapsW ENDP

midiOutGetErrorTextA PROC
    mov rax, QWORD PTR p[69*8]
    jmp rax
midiOutGetErrorTextA ENDP

midiOutGetErrorTextW PROC
    mov rax, QWORD PTR p[70*8]
    jmp rax
midiOutGetErrorTextW ENDP

midiOutGetID PROC
    mov rax, QWORD PTR p[71*8]
    jmp rax
midiOutGetID ENDP

midiOutGetNumDevs PROC
    mov rax, QWORD PTR p[72*8]
    jmp rax
midiOutGetNumDevs ENDP

midiOutGetVolume PROC
    mov rax, QWORD PTR p[73*8]
    jmp rax
midiOutGetVolume ENDP

midiOutLongMsg PROC
    mov rax, QWORD PTR p[74*8]
    jmp rax
midiOutLongMsg ENDP

midiOutMessage PROC
    mov rax, QWORD PTR p[75*8]
    jmp rax
midiOutMessage ENDP

midiOutOpen PROC
    mov rax, QWORD PTR p[76*8]
    jmp rax
midiOutOpen ENDP

midiOutPrepareHeader PROC
    mov rax, QWORD PTR p[77*8]
    jmp rax
midiOutPrepareHeader ENDP

midiOutReset PROC
    mov rax, QWORD PTR p[78*8]
    jmp rax
midiOutReset ENDP

midiOutSetVolume PROC
    mov rax, QWORD PTR p[79*8]
    jmp rax
midiOutSetVolume ENDP

midiOutShortMsg PROC
    mov rax, QWORD PTR p[80*8]
    jmp rax
midiOutShortMsg ENDP

midiOutUnprepareHeader PROC
    mov rax, QWORD PTR p[81*8]
    jmp rax
midiOutUnprepareHeader ENDP

midiStreamClose PROC
    mov rax, QWORD PTR p[82*8]
    jmp rax
midiStreamClose ENDP

midiStreamOpen PROC
    mov rax, QWORD PTR p[83*8]
    jmp rax
midiStreamOpen ENDP

midiStreamOut PROC
    mov rax, QWORD PTR p[84*8]
    jmp rax
midiStreamOut ENDP

midiStreamPause PROC
    mov rax, QWORD PTR p[85*8]
    jmp rax
midiStreamPause ENDP

midiStreamPosition PROC
    mov rax, QWORD PTR p[86*8]
    jmp rax
midiStreamPosition ENDP

midiStreamProperty PROC
    mov rax, QWORD PTR p[87*8]
    jmp rax
midiStreamProperty ENDP

midiStreamRestart PROC
    mov rax, QWORD PTR p[88*8]
    jmp rax
midiStreamRestart ENDP

midiStreamStop PROC
    mov rax, QWORD PTR p[89*8]
    jmp rax
midiStreamStop ENDP

mixerClose PROC
    mov rax, QWORD PTR p[90*8]
    jmp rax
mixerClose ENDP

mixerGetControlDetailsA PROC
    mov rax, QWORD PTR p[91*8]
    jmp rax
mixerGetControlDetailsA ENDP

mixerGetControlDetailsW PROC
    mov rax, QWORD PTR p[92*8]
    jmp rax
mixerGetControlDetailsW ENDP

mixerGetDevCapsA PROC
    mov rax, QWORD PTR p[93*8]
    jmp rax
mixerGetDevCapsA ENDP

mixerGetDevCapsW PROC
    mov rax, QWORD PTR p[94*8]
    jmp rax
mixerGetDevCapsW ENDP

mixerGetID PROC
    mov rax, QWORD PTR p[95*8]
    jmp rax
mixerGetID ENDP

mixerGetLineControlsA PROC
    mov rax, QWORD PTR p[96*8]
    jmp rax
mixerGetLineControlsA ENDP

mixerGetLineControlsW PROC
    mov rax, QWORD PTR p[97*8]
    jmp rax
mixerGetLineControlsW ENDP

mixerGetLineInfoA PROC
    mov rax, QWORD PTR p[98*8]
    jmp rax
mixerGetLineInfoA ENDP

mixerGetLineInfoW PROC
    mov rax, QWORD PTR p[99*8]
    jmp rax
mixerGetLineInfoW ENDP

mixerGetNumDevs PROC
    mov rax, QWORD PTR p[100*8]
    jmp rax
mixerGetNumDevs ENDP

mixerMessage PROC
    mov rax, QWORD PTR p[101*8]
    jmp rax
mixerMessage ENDP

mixerOpen PROC
    mov rax, QWORD PTR p[102*8]
    jmp rax
mixerOpen ENDP

mixerSetControlDetails PROC
    mov rax, QWORD PTR p[103*8]
    jmp rax
mixerSetControlDetails ENDP

mmDrvInstall PROC
    mov rax, QWORD PTR p[104*8]
    jmp rax
mmDrvInstall ENDP

mmGetCurrentTask PROC
    mov rax, QWORD PTR p[105*8]
    jmp rax
mmGetCurrentTask ENDP

mmTaskBlock PROC
    mov rax, QWORD PTR p[106*8]
    jmp rax
mmTaskBlock ENDP

mmTaskCreate PROC
    mov rax, QWORD PTR p[107*8]
    jmp rax
mmTaskCreate ENDP

mmTaskSignal PROC
    mov rax, QWORD PTR p[108*8]
    jmp rax
mmTaskSignal ENDP

mmTaskYield PROC
    mov rax, QWORD PTR p[109*8]
    jmp rax
mmTaskYield ENDP

mmioAdvance PROC
    mov rax, QWORD PTR p[110*8]
    jmp rax
mmioAdvance ENDP

mmioAscend PROC
    mov rax, QWORD PTR p[111*8]
    jmp rax
mmioAscend ENDP

mmioClose PROC
    mov rax, QWORD PTR p[112*8]
    jmp rax
mmioClose ENDP

mmioCreateChunk PROC
    mov rax, QWORD PTR p[113*8]
    jmp rax
mmioCreateChunk ENDP

mmioDescend PROC
    mov rax, QWORD PTR p[114*8]
    jmp rax
mmioDescend ENDP

mmioFlush PROC
    mov rax, QWORD PTR p[115*8]
    jmp rax
mmioFlush ENDP

mmioGetInfo PROC
    mov rax, QWORD PTR p[116*8]
    jmp rax
mmioGetInfo ENDP

mmioInstallIOProcA PROC
    mov rax, QWORD PTR p[117*8]
    jmp rax
mmioInstallIOProcA ENDP

mmioInstallIOProcW PROC
    mov rax, QWORD PTR p[118*8]
    jmp rax
mmioInstallIOProcW ENDP

mmioOpenA PROC
    mov rax, QWORD PTR p[119*8]
    jmp rax
mmioOpenA ENDP

mmioOpenW PROC
    mov rax, QWORD PTR p[120*8]
    jmp rax
mmioOpenW ENDP

mmioRead PROC
    mov rax, QWORD PTR p[121*8]
    jmp rax
mmioRead ENDP

mmioRenameA PROC
    mov rax, QWORD PTR p[122*8]
    jmp rax
mmioRenameA ENDP

mmioRenameW PROC
    mov rax, QWORD PTR p[123*8]
    jmp rax
mmioRenameW ENDP

mmioSeek PROC
    mov rax, QWORD PTR p[124*8]
    jmp rax
mmioSeek ENDP

mmioSendMessage PROC
    mov rax, QWORD PTR p[125*8]
    jmp rax
mmioSendMessage ENDP

mmioSetBuffer PROC
    mov rax, QWORD PTR p[126*8]
    jmp rax
mmioSetBuffer ENDP

mmioSetInfo PROC
    mov rax, QWORD PTR p[127*8]
    jmp rax
mmioSetInfo ENDP

mmioStringToFOURCCA PROC
    mov rax, QWORD PTR p[128*8]
    jmp rax
mmioStringToFOURCCA ENDP

mmioStringToFOURCCW PROC
    mov rax, QWORD PTR p[129*8]
    jmp rax
mmioStringToFOURCCW ENDP

mmioWrite PROC
    mov rax, QWORD PTR p[130*8]
    jmp rax
mmioWrite ENDP

mmsystemGetVersion PROC
    mov rax, QWORD PTR p[131*8]
    jmp rax
mmsystemGetVersion ENDP

sndPlaySoundA PROC
    mov rax, QWORD PTR p[132*8]
    jmp rax
sndPlaySoundA ENDP

sndPlaySoundW PROC
    mov rax, QWORD PTR p[133*8]
    jmp rax
sndPlaySoundW ENDP

timeBeginPeriod PROC
    mov rax, QWORD PTR p[134*8]
    jmp rax
timeBeginPeriod ENDP

timeEndPeriod PROC
    mov rax, QWORD PTR p[135*8]
    jmp rax
timeEndPeriod ENDP

timeGetDevCaps PROC
    mov rax, QWORD PTR p[136*8]
    jmp rax
timeGetDevCaps ENDP

timeGetSystemTime PROC
    mov rax, QWORD PTR p[137*8]
    jmp rax
timeGetSystemTime ENDP

timeGetTime PROC
    mov rax, QWORD PTR p[138*8]
    jmp rax
timeGetTime ENDP

timeKillEvent PROC
    mov rax, QWORD PTR p[139*8]
    jmp rax
timeKillEvent ENDP

timeSetEvent PROC
    mov rax, QWORD PTR p[140*8]
    jmp rax
timeSetEvent ENDP

waveInAddBuffer PROC
    mov rax, QWORD PTR p[141*8]
    jmp rax
waveInAddBuffer ENDP

waveInClose PROC
    mov rax, QWORD PTR p[142*8]
    jmp rax
waveInClose ENDP

waveInGetDevCapsA PROC
    mov rax, QWORD PTR p[143*8]
    jmp rax
waveInGetDevCapsA ENDP

waveInGetDevCapsW PROC
    mov rax, QWORD PTR p[144*8]
    jmp rax
waveInGetDevCapsW ENDP

waveInGetErrorTextA PROC
    mov rax, QWORD PTR p[145*8]
    jmp rax
waveInGetErrorTextA ENDP

waveInGetErrorTextW PROC
    mov rax, QWORD PTR p[146*8]
    jmp rax
waveInGetErrorTextW ENDP

waveInGetID PROC
    mov rax, QWORD PTR p[147*8]
    jmp rax
waveInGetID ENDP

waveInGetNumDevs PROC
    mov rax, QWORD PTR p[148*8]
    jmp rax
waveInGetNumDevs ENDP

waveInGetPosition PROC
    mov rax, QWORD PTR p[149*8]
    jmp rax
waveInGetPosition ENDP

waveInMessage PROC
    mov rax, QWORD PTR p[150*8]
    jmp rax
waveInMessage ENDP

waveInOpen PROC
    mov rax, QWORD PTR p[151*8]
    jmp rax
waveInOpen ENDP

waveInPrepareHeader PROC
    mov rax, QWORD PTR p[152*8]
    jmp rax
waveInPrepareHeader ENDP

waveInReset PROC
    mov rax, QWORD PTR p[153*8]
    jmp rax
waveInReset ENDP

waveInStart PROC
    mov rax, QWORD PTR p[154*8]
    jmp rax
waveInStart ENDP

waveInStop PROC
    mov rax, QWORD PTR p[155*8]
    jmp rax
waveInStop ENDP

waveInUnprepareHeader PROC
    mov rax, QWORD PTR p[156*8]
    jmp rax
waveInUnprepareHeader ENDP

waveOutBreakLoop PROC
    mov rax, QWORD PTR p[157*8]
    jmp rax
waveOutBreakLoop ENDP

waveOutClose PROC
    mov rax, QWORD PTR p[158*8]
    jmp rax
waveOutClose ENDP

waveOutGetDevCapsA PROC
    mov rax, QWORD PTR p[159*8]
    jmp rax
waveOutGetDevCapsA ENDP

waveOutGetDevCapsW PROC
    mov rax, QWORD PTR p[160*8]
    jmp rax
waveOutGetDevCapsW ENDP

waveOutGetErrorTextA PROC
    mov rax, QWORD PTR p[161*8]
    jmp rax
waveOutGetErrorTextA ENDP

waveOutGetErrorTextW PROC
    mov rax, QWORD PTR p[162*8]
    jmp rax
waveOutGetErrorTextW ENDP

waveOutGetID PROC
    mov rax, QWORD PTR p[163*8]
    jmp rax
waveOutGetID ENDP

waveOutGetNumDevs PROC
    mov rax, QWORD PTR p[164*8]
    jmp rax
waveOutGetNumDevs ENDP

waveOutGetPitch PROC
    mov rax, QWORD PTR p[165*8]
    jmp rax
waveOutGetPitch ENDP

waveOutGetPlaybackRate PROC
    mov rax, QWORD PTR p[166*8]
    jmp rax
waveOutGetPlaybackRate ENDP

waveOutGetPosition PROC
    mov rax, QWORD PTR p[167*8]
    jmp rax
waveOutGetPosition ENDP

waveOutGetVolume PROC
    mov rax, QWORD PTR p[168*8]
    jmp rax
waveOutGetVolume ENDP

waveOutMessage PROC
    mov rax, QWORD PTR p[169*8]
    jmp rax
waveOutMessage ENDP

waveOutOpen PROC
    mov rax, QWORD PTR p[170*8]
    jmp rax
waveOutOpen ENDP

waveOutPause PROC
    mov rax, QWORD PTR p[171*8]
    jmp rax
waveOutPause ENDP

waveOutPrepareHeader PROC
    mov rax, QWORD PTR p[172*8]
    jmp rax
waveOutPrepareHeader ENDP

waveOutReset PROC
    mov rax, QWORD PTR p[173*8]
    jmp rax
waveOutReset ENDP

waveOutRestart PROC
    mov rax, QWORD PTR p[174*8]
    jmp rax
waveOutRestart ENDP

waveOutSetPitch PROC
    mov rax, QWORD PTR p[175*8]
    jmp rax
waveOutSetPitch ENDP

waveOutSetPlaybackRate PROC
    mov rax, QWORD PTR p[176*8]
    jmp rax
waveOutSetPlaybackRate ENDP

waveOutSetVolume PROC
    mov rax, QWORD PTR p[177*8]
    jmp rax
waveOutSetVolume ENDP

waveOutUnprepareHeader PROC
    mov rax, QWORD PTR p[178*8]
    jmp rax
waveOutUnprepareHeader ENDP

waveOutWrite PROC
    mov rax, QWORD PTR p[179*8]
    jmp rax
waveOutWrite ENDP

END