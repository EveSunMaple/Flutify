import 'dart:io' show Platform;

import 'package:flutter/foundation.dart';

/// 平台能力判定：集中管理「当前平台支持哪些功能」，避免各处散落 `Platform.isXxx`。
///
/// 背景：Linux 桌面没有 `flutter_inappwebview` 实现，因此内嵌 WebView 相关的
/// 特性（WebView 登录、Widevine/FairPlay EME 全曲播放、Canvas 视频封面、分享嵌入）
/// 在 Linux 上必须优雅降级，而不是在运行期崩溃。
class FlutifyPlatform {
  FlutifyPlatform._();

  /// 是否运行在 widget / 单元测试中（`flutter test` 会设置 `FLUTTER_TEST`）。
  /// 测试里不应触发真实原生能力，登录页等仍走可被 pump 的实现。
  static bool get isTest =>
      !kIsWeb && Platform.environment.containsKey('FLUTTER_TEST');

  /// 当前平台是否有 `flutter_inappwebview` 实现（内嵌 WebView 可用）。
  static bool get supportsInAppWebView =>
      !kIsWeb &&
      (Platform.isWindows ||
          Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isMacOS);

  /// 是否支持通过内嵌 WebView 的 Widevine / FairPlay 做 DRM 全曲播放。
  /// Linux 桌面缺此能力，改走协议（AP 音频密钥 + AES-CTR）链路。
  static bool get supportsEmbeddedDrm => supportsInAppWebView;

  /// Linux 桌面：内嵌 WebView 不可用，登录改走系统浏览器 OAuth；
  /// 全曲播放改走协议（AP 密钥 + AES-CTR）链路。
  static bool get isLinuxDesktop =>
      !kIsWeb && Platform.isLinux && !isTest;

  /// 全曲播放走协议链路而不是内嵌 Widevine 的平台（当前仅 Linux）。
  static bool get usesProtocolPlayback => isLinuxDesktop;
}
