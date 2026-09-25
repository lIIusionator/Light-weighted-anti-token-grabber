# Light-weighted-anti-token-grabber (Sentinel Watch Suite)

A native, single-file Windows C++ security monitor: watches for autorun
changes, new/renamed processes, and suspicious file drops (unsigned
executables, files staged in common credential-theft paths), with an
optional token-guard pass over running processes' open handles. Includes an
AFK screensaver (video + starfield + live clock) that stays up even with the
dashboard closed.

No installer, no dependencies at runtime -- one exe, one source file.

## Build

Requires a mingw-w64 cross toolchain (or MSVC, same command shape). On
Ubuntu/Debian:

```
sudo apt-get install g++-mingw-w64-x86-64
```

Then:

```
x86_64-w64-mingw32-g++ -std=c++17 -O2 -mwindows -municode -static \
  sentinel.cpp -o sentinel.exe -lgdiplus -lshell32 -lgdi32 -luser32 \
  -ladvapi32 -lole32 -loleaut32 -lwbemuuid -luuid -lcrypt32 -lwintrust \
  -lmfplat -lmf -lmfreadwrite -lmfuuid -lsecur32
```

Or just run `build.bat` from a Windows machine with mingw-w64 on PATH.

## AFK screensaver clip

No video is bundled in this source -- that's deliberate, so the published
repo doesn't carry any third-party media. Drop a video (`.mp4`, `.mov`,
`.mkv`, `.webm`, `.avi`, `.wmv`) into `content\afk` next to the exe and it
plays automatically; without one, the screensaver still runs with the
starfield, clock and quotes over a plain dark background.

If you want to bundle your own clip directly into the exe instead of using
the folder, see the `AFK_VIDEO_B64` array and `materializeAfkVideo()` near
the top of `sentinel.cpp` -- encode a clip as base64 in 8000-char chunks
(MSVC's string-literal limit) and set `AFK_VIDEO_RAW_BYTES` to its exact
size. Only do this with a clip you have the rights to redistribute.

Playback caps at 3840x2160 / 240fps regardless of source, scaling down
automatically if a dropped-in clip exceeds that.

## Controls

- **F11** -- toggle fullscreen (fills the work area, leaves the taskbar visible)
- Minimize / close buttons top-right; drag anywhere on the top bar to move

## Requirements

Windows 10/11, x86-64. Uses Media Foundation for AFK video/audio playback and
Windows Management Instrumentation for process monitoring -- both are part
of a standard Windows install.

## License

Add a license of your choosing before treating this as open source in
practice -- the repo doesn't currently declare one.
