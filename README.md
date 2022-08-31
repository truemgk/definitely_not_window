# definitely_not_window

A Flutter package that enables you to easily create custom app bars (i.e. Discord, DefinitelyNotSCM), by removing system ones.
Control your window with ease, using functions like minimize, maximize, close, show, hide, tray, untray etc.;
(Tray and untray still in works)

![example](https://user-images.githubusercontent.com/66747844/187699617-4e86e8a9-e330-46f1-83cb-48ed49ad0b4c.png)

## Features
```
- Custom window frame - remove standard Windows/macOS/Linux titlebar and buttons
- Show/hide window
- Minimize/Maximize/Restore/Close window
- Set window minimum, maximum and current size,
- Set window position on screen
- Set window title

Upcoming
- Minimize window to tray
```
## Getting Started
### Install the package using pubspec.yaml
``` yaml
definitely_not_window:
  git:
    "https://github.com/define-laavi/definitely_not_window.git"
```

### For Windows
Insert this lines at the start of main.cpp
``` cpp
#include <definitely_not_window\definitely_not_window_plugin.h>
auto dnw = dn_window_configure(DN_CUSTOM_FRAME | DN_HIDE_ON_STARTUP);
```
Next, in main method, after runApp:
``` dart
onWindowReady(() {
  window.title = "<Title>";
  window.minSize = const Size(width_in_pixels, height_in_pixels);
  window.show();
});
```
