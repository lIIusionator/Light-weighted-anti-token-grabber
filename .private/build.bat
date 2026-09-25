@echo off
REM Sentinel Watch Suite -- build script.
REM Requires a mingw-w64 toolchain on PATH (x86_64-w64-mingw32-g++).
REM Get one from https://winlibs.com or via MSYS2 (pacman -S mingw-w64-x86_64-gcc).

where x86_64-w64-mingw32-g++ >nul 2>nul
if errorlevel 1 (
  echo x86_64-w64-mingw32-g++ not found on PATH.
  echo Install a mingw-w64 toolchain first ^(see README.md^).
  exit /b 1
)

x86_64-w64-mingw32-g++ -std=c++17 -O2 -mwindows -municode -static ^
  sentinel.cpp -o sentinel.exe -lgdiplus -lshell32 -lgdi32 -luser32 ^
  -ladvapi32 -lole32 -loleaut32 -lwbemuuid -luuid -lcrypt32 -lwintrust ^
  -lmfplat -lmf -lmfreadwrite -lmfuuid -lsecur32

if errorlevel 1 (
  echo Build failed.
  exit /b 1
)
echo Built sentinel.exe
