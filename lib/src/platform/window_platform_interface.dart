import 'dart:ui';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import './base_window.dart';
import './method_channel.dart';

export './base_window.dart';

/// Implement this class if you want to extend DefinitelyNotWindow to other platforms.
///
/// Please make sure that you extend this class rather than implement it - newly added methods will
/// (according to how dart works) break existing implementations, as they do not receive the
/// default implementations and are required to override everything.
abstract class WindowPlatformInterface extends PlatformInterface {
  WindowPlatformInterface() : super(token: _token);

  static final Object _token = Object();

  static final WindowPlatformInterface _channelInstance = MethodChannel();
  static WindowPlatformInterface _instance = _channelInstance;

  ///As an end user you should very rarely use this. All your actions are in the [BaseWindow] class,
  ///that you can get using [window] global getter.
  ///Defaults to [MethodChannel] instance.
  static WindowPlatformInterface get instance => _instance;

  ///Here you are able to set your platform-specific implementation of [WindowPlatformInterface].
  static set instance(WindowPlatformInterface instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  ///Calls the [callback] when the window is considered ready.
  ///WARNING: each implementation may consider a different thing as "window is ready"
  ///so make sure you are wary of that with your [callback].
  void onWindowReady(VoidCallback callback) {
    throw UnimplementedError('doWhenWindowReady() has not been implemented.');
  }

  ///Return current instance of a [window]
  BaseWindow get window {
    throw UnimplementedError('appWindow has not been implemented.');
  }

  ///Helper for starting drag method that is platform specific.
  void drag() async {
    _channelInstance.drag();
  }
}
