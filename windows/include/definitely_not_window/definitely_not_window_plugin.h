#ifndef FLUTTER_PLUGIN_DN_WINDOW_PLUGIN_H_
#define FLUTTER_PLUGIN_DN_WINDOW_PLUGIN_H_

#include <flutter_plugin_registrar.h>

#if defined(__cplusplus)
extern "C"
{
#endif

    void DefinitelyNotWindowPluginRegisterWithRegistrar(
        FlutterDesktopPluginRegistrarRef registrar);

#define DN_CUSTOM_FRAME 0x1
#define DN_HIDE_ON_STARTUP 0x2

    int dn_window_configure(unsigned int flags);

#if defined(__cplusplus)
} // extern "C"
#endif

#endif // FLUTTER_PLUGIN_LAAVI_WINDOW_PLUGIN_H_
