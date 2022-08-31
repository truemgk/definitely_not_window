library laavi_window_windows;

import 'package:definitely_not_window/src/platform/window_platform_interface.dart';
import 'package:flutter/widgets.dart';

import './native_api.dart';
import './window.dart';

class WindowsPlatform extends WindowPlatformInterface {
  WindowsPlatform() : super();

  @override
  void onWindowReady(VoidCallback callback) {
    WidgetsBinding.instance.waitUntilFirstFrameRasterized.then((value) {
      isInsideDoWhenWindowReady = true;
      setWindowCanBeShown(true);
      callback();
      isInsideDoWhenWindowReady = false;
    });
  }

  @override
  BaseWindow get window {
    return WindowsWindow();
  }
}
