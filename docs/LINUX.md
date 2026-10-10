# Flutify on Linux (experimental)

Linux desktop support is **experimental**. The app builds, runs, signs in and
plays full tracks by driving a system **Google Chrome / Chromium** (with
Widevine) in the background.

## Requirements

- Ubuntu 22.04+ (or a compatible distribution) with a desktop session (X11 or
  Wayland).
- Runtime libraries:
  - GTK 3
  - **libmpv** (`libmpv2` on Ubuntu 24.04+, `libmpv1` on 22.04) — the
    `media_kit` audio backend loads `libmpv.so.2` at startup.
- **Google Chrome** (recommended) or another Chromium build that ships the
  Widevine CDM, for full-track (DRM) playback. Flutify launches it with its own
  profile; your normal browser profile is untouched.

The `.deb` declares the library dependencies but cannot depend on the
proprietary Chrome package — install Chrome separately:

```bash
sudo apt install ./Flutify-<label>-linux-x64.deb
# full-track playback also needs Chrome (or Chromium + Widevine):
# https://www.google.com/chrome/
```

## Building from source

```bash
sudo apt-get update
sudo apt-get install -y clang cmake ninja-build pkg-config \
  libgtk-3-dev liblzma-dev libblkid-dev libstdc++-12-dev libmpv2

flutter pub get
flutter build linux --release
tool/package_linux_deb.sh --label v0.13      # -> dist/Flutify-v0.13-linux-x64.deb
```

## Feature support on Linux

| Feature | Status |
|---|---|
| Window chrome, drag, minimize/maximize/close, F11 fullscreen | ✅ self-drawn title bar |
| Account sign-in (system browser + loopback OAuth) | ✅ |
| Full-track playback (Widevine via system Chrome/Chromium) | ✅ needs Chrome + one-time Web sign-in |
| Browsing, search, library, playlists, settings | ✅ |
| Lyrics, Spotify Connect, caching, proxies | ✅ |
| Canvas video artwork | ⚠️ falls back to the static cover |
| Share embed preview | ⚠️ unavailable (iframe code still copyable) |
| System media controls / taskbar lyrics | ⚠️ not implemented on Linux |
| In-app auto-update | ⚠️ open the Releases page |

### How full-track playback works

`flutter_inappwebview` has no Linux implementation, so there is no in-app
WebView. Instead, on Linux Flutify:

1. starts a local HTTP server that serves the same HLS.js/EME host page used on
   Windows/macOS (`lib/services/eme/`);
2. launches a system **Chrome/Chromium** (dedicated profile under the app
   support directory) pointed at that page, and drives it over the Chrome
   DevTools Protocol (`lib/services/eme/chrome/`);
3. the page requests the Widevine license through the app (so the Web player
   token is used), and Chrome decrypts and plays the audio.

By default the Chrome window is placed off-screen (it still needs a real window
to output audio). Set `FLUTIFY_CHROME_HEADLESS=1` to run `--headless=new`
instead. The managed profile persists, so the one-time **Web sign-in** (which
captures the `sp_dc` cookie needed for the Widevine license) only has to be done
once.

The older protocol path (Access Point audio key + AES-CTR) is region-restricted
on many networks and is no longer used.

## Troubleshooting

- **"未找到 Chrome / Chromium"** — install Google Chrome, or a Chromium build
  with the Widevine CDM.
- **"Cannot find libmpv at the usual places"** — install libmpv:
  `sudo apt-get install -y libmpv2`.
- **Playback silent but position advances** — try a normal (non-headless)
  Chrome window: launch without `FLUTIFY_CHROME_HEADLESS`.
- **No audio device** — make sure PipeWire/PulseAudio is running for your
  session; `media_kit` plays through the default sink.
- **Window has no decorations** — expected; Flutify draws its own title bar.
  If the window manager ignores it, use `Alt`-drag to move the window.
- **Tray/media keys do nothing** — system media controls are not implemented on
  Linux yet.
