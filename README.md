# definitely_not_window

A Flutter package that enables you to easily create custom app bars (i.e. Discord, DefinitelyNotSCM), by removing system ones.
Control your window with ease, using functions like minimize, maximize, close, show, hide, tray, untray etc.;
(Tray and untray still in works)

## Features

## Getting Started
### Install the package using pubspec.yaml
```
definitely_not_window:
  git:
    "https://github.com/define-laavi/definitely_not_window.git"
```

### For Windows
Insert this lines at the start of main.cpp
```
#include <definitely_not_window\definitely_not_window_plugin.h>
auto dnw = dn_window_configure(DN_CUSTOM_FRAME | DN_HIDE_ON_STARTUP);
```
Next, in main method, after runApp:
```
onWindowReady(() {
  window.title = "<Title>";
  window.minSize = const Size(width_in_pixels, height_in_pixels);
  window.show();
});
```
