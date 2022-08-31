import 'package:flutter/painting.dart';

abstract class BaseWindow {
  BaseWindow();

  ///Don't touch unless implementing new [WindowPlatformInterface]. Returns the system specific handle for the window.
  int? handle;

  ///Returns window scale factor;
  double get scaleFactor;

  ///Gets window rect on screen;
  Rect get rect;

  ///Sets window rect on screen;
  set rect(Rect value);

  ///Gets window position on screen in pixels;
  Offset get position;

  ///Sets window position on screen in pixels;
  set position(Offset value);

  ///Gets window size on screen in pixels;
  Size get size;

  ///Sets window size on screen in pixels;
  set size(Size value);

  ///Sets the minimum size for the window; Providing [null] removes the restriction;
  set minSize(Size? value);

  ///Sets the maximum size for the window; Providing [null] removes the restriction;
  set maxSize(Size? value);

  ///Sets window title;
  set title(String value);

  ///Returns if the window is currently visible.
  bool get isVisible;

  ///Returns if the window is currently maximized.
  bool get isMaximized;

  ///Shows the window. If you want to restore the window, use [restore()].
  void show();

  ///Hides the window. If you want to minimize the window use [minimize()].
  void hide();

  ///Quits the application.
  void close();

  ///Minimizes the window to taksbar.
  void minimize();

  ///Maximizes the window.
  void maximize();

  ///Restores the window from maximized state.
  void restore();

  ///Automatically toggles between maximized and restored state;
  void toggle();

  ///Starts the window dragging;
  void drag();

  ///Todo: hide to tray and show from tray; [Only if tray extension is detected]

}
