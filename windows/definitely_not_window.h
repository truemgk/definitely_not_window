#ifndef DN_WINDOW_H_
#define DN_WINDOW_H_
#include <windows.h>

namespace dn_window
{
    typedef bool (*TIsWindowLoaded)();
    bool isWindowLoaded();

    typedef void (*TSetWindowCanBeShown)(bool);
    void setWindowCanBeShown(bool value);

    typedef bool (*TDragWindow)();
    bool dragWindow();

    typedef HWND (*TGetWindow)();
    HWND getWindow();

    typedef void (*TSetMinSize)(int, int);
    void setMinSize(int width, int height);

    typedef void (*TSetMaxSize)(int, int);
    void setMaxSize(int width, int height);

    typedef void (*TSetWindowCutOnMaximize)(int);
    void setWindowCutOnMaximize(int value);
}
#endif