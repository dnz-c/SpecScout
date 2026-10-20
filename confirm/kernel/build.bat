@echo off
setlocal enableextensions enabledelayedexpansion
cd /d "%~dp0"
rem build.bat - build the SpecScout kernel confirmer (driver + user client).
rem Sets the MSVC + WDK/SDK environment directly (no vcvars), so it works from a
rem plain shell. Requires Visual Studio 2022 (x64 tools) and the WDK installed.
rem
rem This only BUILDS. Loading the driver needs admin + test-signing + REBOOT
rem (see README); never load it on a machine you cannot afford to bugcheck.

rem --- newest MSVC x64 toolset -------------------------------------------------
set "VSROOT=C:\Program Files\Microsoft Visual Studio\2022"
set "MSVC="
for %%e in (Community Professional Enterprise BuildTools) do (
  if exist "%VSROOT%\%%e\VC\Tools\MSVC" (
    for /f "delims=" %%v in ('dir /b /ad /on "%VSROOT%\%%e\VC\Tools\MSVC"') do set "MSVC=%VSROOT%\%%e\VC\Tools\MSVC\%%v"
  )
)
if not defined MSVC ( echo [build] MSVC x64 toolset not found & exit /b 1 )
echo [build] MSVC: !MSVC!

rem --- newest Windows Kit with both km (driver) and um (client) ----------------
set "WK=C:\Program Files (x86)\Windows Kits\10"
set "KVER="
for /f "delims=" %%v in ('dir /b /ad /on "%WK%\Include"') do (
  if exist "%WK%\Include\%%v\km\wdm.h" if exist "%WK%\Include\%%v\um\windows.h" set "KVER=%%v"
)
if not defined KVER ( echo [build] no Windows Kit with km+um headers found & exit /b 1 )
echo [build] WDK/SDK: !KVER!

set "PATH=!MSVC!\bin\Hostx64\x64;%PATH%"

rem --- driver (.sys): km + shared headers, km x64 libs, no CRT -----------------
rem km CRT headers must precede MSVC\include so the kernel crtdefs.h wins.
set "INCLUDE=%WK%\Include\!KVER!\km\crt;%WK%\Include\!KVER!\km;%WK%\Include\!KVER!\shared;!MSVC!\include"
set "LIB=%WK%\Lib\!KVER!\km\x64"

echo [build] compiling driver.c
cl /nologo /c /O2 /W3 /GS- /Gy /kernel /DWIN32 /D_AMD64_ /DAMD64 /D_WIN64 ^
   /DNTDDI_VERSION=0x0A000008 driver.c /Fo:driver.obj
if errorlevel 1 ( echo [build] driver compile FAILED & exit /b 1 )

echo [build] linking specscout_kc.sys
link /nologo /DRIVER /SUBSYSTEM:NATIVE,10.00 /ENTRY:DriverEntry /NODEFAULTLIB ^
     /RELEASE /MACHINE:X64 ^
     ntoskrnl.lib hal.lib BufferOverflowK.lib wdmsec.lib ^
     driver.obj /OUT:specscout_kc.sys
if errorlevel 1 ( echo [build] driver link FAILED & exit /b 1 )
echo [build] specscout_kc.sys OK

rem --- user-mode client: ucrt/um/shared headers, ucrt/um/MSVC libs ------------
set "INCLUDE=!MSVC!\include;%WK%\Include\!KVER!\ucrt;%WK%\Include\!KVER!\um;%WK%\Include\!KVER!\shared"
set "LIB=!MSVC!\lib\x64;%WK%\Lib\!KVER!\ucrt\x64;%WK%\Lib\!KVER!\um\x64"

echo [build] compiling kc_client.exe
cl /nologo /O2 /std:c++17 /EHsc /W3 client.cpp /Fe:kc_client.exe /link kernel32.lib
if errorlevel 1 ( echo [build] client build FAILED & exit /b 1 )
echo [build] kc_client.exe OK

del /q driver.obj client.obj >nul 2>&1
echo [build] done.
endlocal
