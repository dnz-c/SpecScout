@echo off
REM build.bat - build the CtiIo64.sys Spectre-v1 PoC (x64, MSVC).
cl /nologo /O2 /W3 poc.c /Fe:poc.exe advapi32.lib
if %errorlevel% equ 0 echo OK: poc.exe
