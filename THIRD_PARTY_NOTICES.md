# 第三方组件声明 / Third-Party Notices

Flutify 自身的源代码以 [MIT License](LICENSE) 发布。下列随仓库或安装包分发的第三方组件**不受该许可约束**，
各自遵循其原始许可证。

## 随安装包分发的原生库（Windows）

| 组件 | 文件 | 许可证 | 源码 |
|---|---|---|---|
| mpv（`-Dgpl=false`） | `libmpv-2.dll` | LGPL-2.1-or-later | <https://github.com/mpv-player/mpv>；x64 构建脚本 <https://github.com/media-kit/libmpv-win32-audio-build>；ARM64 构建脚本 <https://github.com/media-kit/libmpv-win32-video-cmake> |
| FFmpeg（`--disable-gpl --disable-nonfree --enable-version3`） | 静态链接于 `libmpv-2.dll` | LGPL-3.0-or-later | <https://ffmpeg.org>；构建脚本同上 |
| Microsoft Edge WebView2 Loader | `WebView2Loader.dll` | Microsoft WebView2 SDK 许可（允许随应用再分发） | <https://www.nuget.org/packages/Microsoft.Web.WebView2> |
| Microsoft Visual C++ Runtime | `msvcp140*.dll`、`vcruntime140*.dll`、`concrt140.dll` | Microsoft Visual Studio 可再分发代码许可 | <https://learn.microsoft.com/cpp/windows/redistributing-visual-cpp-files> |

`libmpv-2.dll` 由仓库内 `packages/media_kit_libs_windows_audio` 在构建时下载；它基于
[media_kit_libs_windows_audio 1.0.9](https://pub.dev/packages/media_kit_libs_windows_audio)（MIT），添加了架构选择与 SHA-256 校验。
x64 使用音频精简版 [2023-09-24 / 652a1dd](https://github.com/media-kit/libmpv-win32-audio-build/releases/tag/2023-09-24)，
ARM64 使用 [2024-10-21 / 0f78584](https://github.com/media-kit/libmpv-win32-video-cmake/releases/tag/20241021)（mpv 0.39.0，FFmpeg 7.1；启用视频功能，但本应用只使用音频）。
两种二进制均未修改；对应源码与构建脚本见上表。它以动态链接方式使用，用户可以用自行编译的同名、接口兼容的库替换它。
LGPL 全文：<https://www.gnu.org/licenses/lgpl-2.1.html>、<https://www.gnu.org/licenses/lgpl-3.0.html>。

## 随安装包分发的原生库（Linux）

Linux 构建**不打包** libmpv，而是在运行期动态加载系统安装的 `libmpv.so.2`（`media_kit` 音频后端）。
`.deb` 将 `libmpv2` 声明为依赖。libmpv 与 FFmpeg 的许可证同上（LGPL-2.1-or-later / LGPL-3.0-or-later），
以动态链接方式使用，用户可自行替换系统库。

全曲（Widevine）播放会调用系统安装的 **Google Chrome / Chromium**（独立 profile，经 DevTools 协议驱动），
Flutify 不打包、不修改该浏览器，其许可证归 Google / 各发行方所有。

## 随仓库分发的资源

| 组件 | 路径 | 许可证 |
|---|---|---|
| MiSans 字体（小米） | `assets/fonts/MiSans/` | 《MiSans 字体知识产权许可协议》：可免费用于个人与商业用途（含嵌入软件分发）；不得改编、二次开发或单独出售字体。版权归小米所有，以 <https://hyperos.mi.com/font/> 为准 |
| hls.js | `assets/js/hls.min.js` | Apache License 2.0，<https://github.com/video-dev/hls.js> |

## Dart / Flutter 依赖

全部为宽松许可证（BSD、MIT、Apache-2.0、公有领域），无 GPL / LGPL 依赖。完整清单与许可证全文可在 App 内
**设置 → 关于 → 开源许可** 查看（由 Flutter 根据 `pubspec.lock` 自动汇总）。Android 端音频播放使用的 ExoPlayer
（经 just_audio）为 Apache License 2.0。

## 商标

Spotify 是 Spotify AB 的商标。Flutify 与 Spotify AB 无任何关联，未获其认可或授权。
