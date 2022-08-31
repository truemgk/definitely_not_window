#ifndef DN_WINDOW_API_H
#define DN_WINDOW_API_H

#include "common.h"
#include "definitely_not_window.h"

namespace dn_window
{

    typedef struct _DNPrivateAPI
    {
        TDrag drag;
    } DNPrivateAPI;

    typedef struct _DNPublicAPI
    {
        TIsWindowLoaded isWindowLoaded;
        TGetWindow getWindow;
        TSetWindowCanBeShown setWindowCanBeShown;
        TSetMinSize setMinSize;
        TSetMaxSize setMaxSize;
        TSetWindowCutOnMaximize setWindowCutOnMaximize;
    } DNPublicAPI;

}

typedef struct _DNAPI
{
    dn_window::DNPublicAPI *publicAPI;
    dn_window::DNPrivateAPI *privateAPI;
} DNAPI;

DN_EXPORT DNAPI *dn_window_api();
#endif