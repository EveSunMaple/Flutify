<div align="center">

<img src="assets/brand/flutify_logo_1024.png" width="112" alt="Flutify" />

# Flutify

一个让你呼吸通畅的 Spotify 第三方客户端 · Windows / Android / macOS（测试版）· Linux（实验）

[下载](https://github.com/is-hp-is-mad/Flutify/releases) · 当前版本 [![最新版本（含 Beta）](https://img.shields.io/github/v/release/is-hp-is-mad/Flutify?include_prereleases&sort=date&label=release&cacheSeconds=300)](https://github.com/is-hp-is-mad/Flutify/releases)

</div>

---

## ✨ 功能

**听歌**
- 在应用内的 Spotify 官方登录页登录一次即可，其余授权自动完成，浏览主页、搜索、歌单、专辑、艺人
- 完整曲目播放，边下边播，听过的歌自动缓存
- 双层播放队列（手动添加 + 来自歌单），随机 / 列表循环 / 单曲循环
- 音量均衡、歌曲间淡入淡出，重启后从上次的进度继续

**歌词**
- 逐行同步歌词，Apple Music 风格的流动背景与液态玻璃
- 官方没有同步歌词时，自动从 [LRCLIB](https://lrclib.net) 补全
- 可选双语歌词：保留 LRCLIB 对照译文，或查询网易云社区译文并按时间轴对齐
- 桌面沉浸式歌词（F11），支持直接收藏歌曲
- Windows 任务栏歌词：嵌在任务栏里，不需要额外软件

**Spotify Connect**
- 遥控同账号的其他设备（手机、电脑、音箱），也能把播放转到本机
- 本机会出现在其他设备的设备列表里，可以被遥控，播放状态双向同步
- 设备名称可自定义

**外观与体验**
- Material 3 Expressive 设计，深 / 浅色，纯黑背景，强调色可跟随封面
- 桌面三栏布局，窗口变窄自动切换为手机布局
- 系统媒体控制（任务栏 / 锁屏 / 通知栏）、键盘媒体键与快捷键
- 简体中文 / 繁體中文 / English / 日本語，内置 MiSans 字体
- 支持 HTTP 代理（跟随系统或手动设置）
- 可配置 Spotify HTTPS 反代，支持 API、媒体和 Connect 连接，并按网络出口国家/地区自动开关
- 桌面端的音频、封面、歌词缓存分别选择 AppData、程序目录或自定义目录，支持系统文件夹选择器，修改位置时迁移旧缓存
- 音频缓存按上限自动清理，也可手动清理全部缓存；网络连接失败时最多重试 10 次并显示进度

## 📦 安装

从 [Releases](../../releases) 下载：

| 平台 | 文件 | 说明 |
|---|---|---|
| Windows 10 / 11，Intel / AMD | `*-windows-x64-setup.exe` 或 `*-windows-x64.zip` | 安装版或解压即用的便携版 |
| Windows ARM64 | `*-windows-arm64-setup.exe` 或 `*-windows-arm64.zip` | 原生 ARM64 安装版或便携版 |
| Android | `*-android-arm64-v8a.apk` | 绝大多数手机选这个；不确定就选 `*-android-universal.apk` |
| macOS | Releases 中的 `*-macos.zip` | 测试版，未做 Developer ID 签名和 Apple 公证；见 [macOS 开发说明](docs/MACOS.md) |
| Linux（实验） | `*-linux-x64.deb` | Ubuntu 22.04+，`sudo apt install ./Flutify-*-linux-x64.deb`；见 [Linux 说明](docs/LINUX.md) |

Windows 便携版解压后运行 `Flutify.exe`。两种发行方式均附带 MSVC 运行库；播放仍需 WebView2 运行时（Windows 11 通常已安装）。安装版默认安装到当前用户目录，也可更改位置。

桌面端缓存位置在「设置 → 存储」中分别调整；便携版默认仍使用 AppData，需要时可切换到程序目录。移动端保留清除缓存和设置大小上限，不显示目录选择。

反代入口与凭据在「设置 → 网络 → Spotify 反代」中配置。开启自动切换后，通过 `https://cloudflare.com/cdn-cgi/trace` 的 `loc` 查询出口国家/地区：允许直连的国家/地区代码留空时，CN 开启反代，其余直连；填写 `US, JP, HK` 等两位代码时，仅列表内的国家/地区直连，其余全部开启反代。查询使用当前选择的系统/手动 HTTP 代理，失败时保持现有线路。启动、网络变化、回到前台和每两分钟都会检查，也可在设置中手动刷新。

首次使用：设置 → 账号 →「登录」，在弹出的 Spotify 官方登录页里登录即可。

## 🌐 可选自建服务

[FlutifyPS](https://github.com/is-hp-is-mad/FlutifyPS) 是 Flutify 的可选反代服务，支持 Spotify API、媒体下载和 Connect 连接。如果当前网络已经可以正常使用 Flutify，无需部署它。

需要自建入口时，按 [FlutifyPS 部署与接入说明](https://github.com/is-hp-is-mad/FlutifyPS#部署) 在服务器上部署，然后在「设置 → 网络 → Spotify 反代」中填写包含路径的 HTTPS 地址、用户名和密码。FlutifyPS 支持 Docker 与 Node.js / systemd，服务器也可配置独立出口代理。

## 🧪 已知问题

- **0.13（正式版）：Windows 原生 Widevine 仍为实验性。** x64 开启实验性原生 Widevine，加载失败回退 WebView2，ARM64 继续使用 WebView2。原生实验的许可证请求仍返回 HTTP 403，尚未验证原生出声。本版改动见 [0.13 更新日志](docs/releases/v0.13.md)。

- Android 已接入 Media3 / 系统 Widevine 原生播放；设备 DRM 支持和厂商系统媒体卡片仍有兼容性差异
- vivo 媒体卡片、手机与 PC 间控制权转移、手机歌词退出遮罩及 Windows 左对齐任务栏歌词仍需实机反馈
- 偶尔遇到播放限流（HTTP 429），稍等片刻再试即可
- 免费账号功能以 Spotify 实际允许的为准；与旧版签名不同的 Android Beta 安装可能需要首次重装
- macOS 仍需不同机型、系统版本与账号的实机验证；构建通过不代表全曲播放、系统媒体键等均已验证
- **Linux（实验）：** 没有内嵌 WebView，全曲播放改用一个后台运行的系统 Google Chrome / Chromium（含 Widevine）来完成（本机需装 Chrome）；账号登录走系统浏览器，全曲播放需一次性「Web 登录」抓取 sp_dc。Canvas 视频封面、分享嵌入、系统媒体控制与任务栏歌词不可用，应用内更新走 Releases 页面。运行需要 `libmpv`（`.deb` 已声明依赖）。详见 [Linux 说明](docs/LINUX.md)

有问题欢迎提 [Issue](../../issues)。

## ⚠️ 免责声明

- 本项目是非官方第三方客户端，**与 Spotify AB 没有任何关联**，Spotify 是 Spotify AB 的注册商标。
- 本项目仅供学习与研究交流使用。使用第三方客户端可能违反 Spotify 服务条款，**存在账号被限制的风险，建议使用小号**，后果由使用者自行承担。
- 本项目不提供、不存储任何音乐内容，所有内容均来自用户自己的 Spotify 账号。
- 请支持正版，订阅 Spotify Premium。

## 📄 许可证

[MIT License](LICENSE)。随附的第三方组件遵循各自的许可证，见 [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)。

开发相关文档见 [docs/DEVELOPMENT.md](docs/DEVELOPMENT.md)。

## 🙏 致谢

感谢 <a href="https://linux.do">LINUX DO</a> 社区。
