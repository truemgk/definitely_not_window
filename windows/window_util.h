#ifndef DN_WINDOW_UTIL_H_
#define DN_WINDOW_UTIL_H_

#define WM_DN_ACTION 0x7FFE

#define DN_SETWINDOWPOS 1
#define DN_SETWINDOWTEXT 2
#define DN_FORCECHILDREFRESH 3

typedef struct _SWPParam
{
    int x;
    int y;
    int cx;
    int cy;
    UINT uFlags;
} SWPParam;

typedef struct _SWTParam
{
    LPCWSTR text;
} SWTParam;

#endif
