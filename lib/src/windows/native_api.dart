library laavi_window_windows;

import 'dart:ffi';

final DynamicLibrary _appExecutable = DynamicLibrary.executable();

typedef TIsWindowLoaded = Int8 Function();
typedef DTIsWindowLoaded = int Function();
final DTIsWindowLoaded _isWindowLoaded =
    _publicAPI.ref.isWindowLoaded.asFunction();

bool isWindowLoaded() {
  return _isWindowLoaded() == 1 ? true : false;
}

// getAppWindow
typedef TGetWindow = IntPtr Function();
typedef DGetWindow = int Function();
final DGetWindow getWindow = _publicAPI.ref.getWindow.asFunction();

// setWindowCanBeShown
typedef TSetWindowCanBeShown = Void Function(Int8 value);
typedef DSetWindowCanBeShown = void Function(int value);
final DSetWindowCanBeShown _setWindowCanBeShown =
    _publicAPI.ref.setWindowCanBeShown.asFunction();
void setWindowCanBeShown(bool value) => _setWindowCanBeShown(value ? 1 : 0);

// setMinSize
typedef TSetMinSize = Void Function(Int32 width, Int32 height);
typedef DSetMinSize = void Function(int width, int height);
final DSetMinSize setMinSize = _publicAPI.ref.setMinSize.asFunction();

// setMaxSize
typedef TSetMaxSize = Void Function(Int32 width, Int32 height);
typedef DSetMaxSize = void Function(int width, int height);
final DSetMinSize setMaxSize = _publicAPI.ref.setMaxSize.asFunction();

// setWindowCutOnMaximize
typedef TSetWindowCutOnMaximize = Void Function(Int32 width);
typedef DSetWindowCutOnMaximize = void Function(int width);
final DSetWindowCutOnMaximize setWindowCutOnMaximize =
    _publicAPI.ref.setWindowCutOnMaximize.asFunction();

class LWPublicAPI extends Struct {
  external Pointer<NativeFunction<TIsWindowLoaded>> isWindowLoaded;
  external Pointer<NativeFunction<TGetWindow>> getWindow;
  external Pointer<NativeFunction<TSetWindowCanBeShown>> setWindowCanBeShown;
  external Pointer<NativeFunction<TSetMinSize>> setMinSize;
  external Pointer<NativeFunction<TSetMaxSize>> setMaxSize;
  external Pointer<NativeFunction<TSetWindowCutOnMaximize>>
      setWindowCutOnMaximize;
}

class DNWAPI extends Struct {
  external Pointer<LWPublicAPI> publicAPI;
}

typedef TWindowAPI = Pointer<DNWAPI> Function();

final TWindowAPI windowAPI = _appExecutable
    .lookup<NativeFunction<TWindowAPI>>("dn_window_api")
    .asFunction();

final Pointer<LWPublicAPI> _publicAPI = windowAPI().ref.publicAPI;
