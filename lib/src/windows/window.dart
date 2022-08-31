import 'dart:ffi' as dffi;

import 'package:ffi/ffi.dart' as ffi;
import 'package:flutter/foundation.dart';
import 'package:flutter/painting.dart';
import 'package:win32/win32.dart' hide Rect, Size;

import './native_api.dart' as native;
import './win32_plus.dart';
import './window_util.dart';
import '../platform/window_platform_interface.dart';
import 'native_api.dart';

var isInsideDoWhenWindowReady = false;

bool isValidHandle(int? handle, String operation) {
  if (handle == null) {
    if (kDebugMode) {
      print("Could not $operation - handle is null");
    }
    return false;
  }
  return true;
}

Rect getScreenRectForWindow(int handle) {
  int monitor = MonitorFromWindow(handle, MONITOR_DEFAULTTONEAREST);
  final monitorInfo = ffi.calloc<MONITORINFO>()
    ..ref.cbSize = dffi.sizeOf<MONITORINFO>();
  final result = GetMonitorInfo(monitor, monitorInfo);
  if (result == TRUE) {
    return Rect.fromLTRB(
        monitorInfo.ref.rcWork.left.toDouble(),
        monitorInfo.ref.rcWork.top.toDouble(),
        monitorInfo.ref.rcWork.right.toDouble(),
        monitorInfo.ref.rcWork.bottom.toDouble());
  }
  return Rect.zero;
}

class WindowNotInitializedException implements Exception {
  String errMsg() => "DefinitelyNotWindow is not initalized yet!";
}

class WindowsWindow extends BaseWindow {
  WindowsWindow._() {
    super.handle = getWindow();
    final isLoaded = isWindowLoaded();
    if (!isLoaded) {
      throw WindowNotInitializedException;
    }
    assert(handle != null, "Could not get Flutter window");
  }

  static final WindowsWindow _instance = WindowsWindow._();

  factory WindowsWindow() {
    return _instance;
  }

  Size? _minSize;
  Size? _maxSize;
  Size? _sizeSetFromDart;

  void setWindowCutOnMaximize(int value) {
    native.setWindowCutOnMaximize(value);
  }

  @override
  Rect get rect {
    if (!isValidHandle(handle, "get rectangle")) return Rect.zero;
    final winRect = ffi.calloc<RECT>();
    GetWindowRect(handle!, winRect);
    Rect result = winRect.ref.toRect;
    ffi.calloc.free(winRect);
    return result;
  }

  @override
  set rect(Rect value) {
    if (!isValidHandle(handle, "set rectangle")) return;
    setWindowPos(handle!, 0, value.left.toInt(), value.top.toInt(),
        value.width.toInt(), value.height.toInt(), 0);
  }

  @override
  Size get size {
    final winRect = rect;
    final gotSize = getLogicalSize(Size(winRect.width, winRect.height));
    return gotSize;
  }

  Size get sizeOnScreen {
    if (isInsideDoWhenWindowReady == true) {
      if (_sizeSetFromDart != null) {
        final sizeOnScreen = getSizeOnScreen(_sizeSetFromDart!);
        return sizeOnScreen;
      }
    }
    final winRect = rect;
    return Size(winRect.width, winRect.height);
  }

  double systemMetric(int metric, {int dpiToUse = 0}) {
    final windowDpi = dpiToUse != 0 ? dpiToUse : dpi;
    double result = GetSystemMetricsForDpi(metric, windowDpi).toDouble();
    return result;
  }

  int get dpi {
    if (!isValidHandle(handle, "get dpi")) return 96;
    return GetDpiForWindow(handle!);
  }

  @override
  double get scaleFactor {
    double result = dpi / 96.0;
    return result;
  }

  Size getSizeOnScreen(Size value) {
    double scaleFactor = this.scaleFactor;
    double newWidth = value.width * scaleFactor;
    double newHeight = value.height * scaleFactor;
    return Size(newWidth, newHeight);
  }

  Size getLogicalSize(Size value) {
    double scaleFactor = this.scaleFactor;
    double newWidth = value.width / scaleFactor;
    double newHeight = value.height / scaleFactor;
    return Size(newWidth, newHeight);
  }

  @override
  set minSize(Size? value) {
    _minSize = value;
    if (value == null) {
      native.setMinSize(0, 0);
      return;
    }
    native.setMinSize(_minSize!.width.toInt(), _minSize!.height.toInt());
  }

  @override
  set maxSize(Size? value) {
    _maxSize = value;
    if (value == null) {
      //TODO - add handling for setting maxSize to null
      return;
    }
    native.setMaxSize(_maxSize!.width.toInt(), _maxSize!.height.toInt());
  }

  @override
  set size(Size value) {
    if (!isValidHandle(handle, "set size")) return;

    var width = value.width;

    if (_minSize != null) {
      if (value.width < _minSize!.width) width = _minSize!.width;
    }

    if (_maxSize != null) {
      if (value.width > _maxSize!.width) width = _maxSize!.width;
    }

    var height = value.height;

    if (_minSize != null) {
      if (value.height < _minSize!.height) height = _minSize!.height;
    }

    if (_maxSize != null) {
      if (value.height > _maxSize!.height) height = _maxSize!.height;
    }

    Size sizeToSet = Size(width, height);
    _sizeSetFromDart = sizeToSet;
    SetWindowPos(handle!, 0, 0, 0, sizeToSet.width.toInt(),
        sizeToSet.height.toInt(), SWP_NOMOVE);
  }

  @override
  bool get isVisible {
    if (!isValidHandle(handle, "get isVisible")) return false;
    return (IsWindowVisible(handle!) == 1);
  }

  @override
  bool get isMaximized {
    if (!isValidHandle(handle, "get isMaximized")) return false;
    return (IsZoomed(handle!) == 1);
  }

  @override
  Offset get position {
    final winRect = rect;
    return Offset(winRect.left, winRect.top);
  }

  @override
  set position(Offset value) {
    if (!isValidHandle(handle, "set position")) return;
    SetWindowPos(
        handle!, 0, value.dx.toInt(), value.dy.toInt(), 0, 0, SWP_NOSIZE);
  }

  @override
  void show() {
    if (!isValidHandle(handle, "show")) return;
    SetWindowPos(
        handle!, 0, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE | SWP_SHOWWINDOW);
    forceChildRefresh(handle!);
  }

  @override
  void hide() {
    if (!isValidHandle(handle, "hide")) return;
    SetWindowPos(
        handle!, 0, 0, 0, 0, 0, SWP_NOSIZE | SWP_NOMOVE | SWP_HIDEWINDOW);
  }

  @override
  void close() {
    if (!isValidHandle(handle, "close")) return;
    PostMessage(handle!, WM_SYSCOMMAND, SC_CLOSE, 0);
  }

  @override
  void maximize() {
    if (!isValidHandle(handle, "maximize")) return;
    PostMessage(handle!, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
  }

  @override
  void minimize() {
    if (!isValidHandle(handle, "minimize")) return;
    PostMessage(handle!, WM_SYSCOMMAND, SC_MINIMIZE, 0);
  }

  @override
  void restore() {
    if (!isValidHandle(handle, "restore")) return;
    PostMessage(handle!, WM_SYSCOMMAND, SC_RESTORE, 0);
  }

  @override
  void toggle() {
    if (!isValidHandle(handle, "toggle")) return;
    if (IsZoomed(handle!) == 1) {
      restore();
    } else {
      maximize();
    }
  }

  @override
  set title(String value) {
    if (!isValidHandle(handle, "set title")) return;
    setWindowText(handle!, value);
  }

  @override
  void drag() {
    WindowPlatformInterface.instance.drag();
  }
}
