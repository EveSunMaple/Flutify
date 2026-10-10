import 'dart:io';

import 'package:flutify_app/core/platform/flutify_platform.dart';
import 'package:flutter_test/flutter_test.dart';

/// 平台能力判定：Linux 桌面的降级分支依赖这些 getter。
void main() {
  test('测试环境下 isTest 为真，且不会启用 Linux 桌面专属分支', () {
    expect(FlutifyPlatform.isTest, isTrue);
    expect(FlutifyPlatform.isLinuxDesktop, isFalse);
    expect(FlutifyPlatform.usesProtocolPlayback, isFalse);
  });

  test('内嵌 WebView 能力与当前宿主平台一致（测试宿主不含 WebView）', () {
    final expected = Platform.isWindows ||
        Platform.isAndroid ||
        Platform.isIOS ||
        Platform.isMacOS;
    expect(FlutifyPlatform.supportsInAppWebView, expected);
  });
}
