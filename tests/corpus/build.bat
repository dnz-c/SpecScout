@echo off
setlocal
call "C:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat" >nul 2>&1
cd /d "%~dp0out"
set SRC=%~dp0
echo Building s1 (no mitigation)...
cl /nologo /MD /O2 /std:c++17 /EHsc "%SRC%s1_fread.cpp" /Fe:s1.exe >nul || goto :err
echo Building s1 (/Qspectre)...
cl /nologo /MD /O2 /Qspectre /std:c++17 /EHsc "%SRC%s1_fread.cpp" /Fe:s1_q.exe >nul || goto :err
echo Building s2 (no mitigation)...
cl /nologo /MD /O2 /std:c++17 /EHsc "%SRC%s2_fread.cpp" /Fe:s2.exe >nul || goto :err
echo Building s2 (/Qspectre)...
cl /nologo /MD /O2 /Qspectre /std:c++17 /EHsc "%SRC%s2_fread.cpp" /Fe:s2_q.exe >nul || goto :err
echo BUILD_OK
exit /b 0
:err
echo BUILD_FAILED
exit /b 1
