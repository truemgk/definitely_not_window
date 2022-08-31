import 'dart:io';

import 'package:flutter/foundation.dart';

import 'platform/method_channel.dart';
import 'platform/window_platform_interface.dart';
import 'windows/windows_platform_interface.dart';

bool _platformInstanceNeedsInit = true;

void initPlatformInstance() {
  if (!kIsWeb) {
    if (WindowPlatformInterface.instance is MethodChannel) {
      if (Platform.isWindows) {
        WindowPlatformInterface.instance = WindowsPlatform();
      }
    }
  }
}

WindowPlatformInterface get _platform {
  var needsInit = _platformInstanceNeedsInit;
  if (needsInit) {
    initPlatformInstance();
    _platformInstanceNeedsInit = false;
  }
  return WindowPlatformInterface.instance;
}

void onWindowReady(VoidCallback callback) {
  _platform.onWindowReady(callback);
}

BaseWindow get window => _platform.window;
