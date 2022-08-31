import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' as service;

import 'window_platform_interface.dart';

const service.MethodChannel _channel =
    service.MethodChannel('definitely_not/window');

/// An implementation of [WindowPlatformInterface] that uses method channels.
class MethodChannel extends WindowPlatformInterface {
  @override
  void drag() async {
    try {
      await _channel.invokeMethod('drag');
    } catch (e) {
      if (kDebugMode) {
        print("[DRAG ERROR]: $e");
      }
    }
  }
}
