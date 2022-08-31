#include "api.h"
#include "common.h"
#include "definitely_not_window.h"

namespace dn_window
{
    DNPrivateAPI privateAPI = {
        drag};

    DNPublicAPI publicAPI = {
        isWindowLoaded,
        getWindow,
        setWindowCanBeShown,
        setMinSize,
        setMaxSize,
        setWindowCutOnMaximize};
}

DNAPI dnAPI = {
    &dn_window::publicAPI,
    &dn_window::privateAPI};

DN_EXPORT DNAPI *dn_window_api()
{
    return &dnAPI;
}