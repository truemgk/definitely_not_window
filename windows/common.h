#ifndef DN_COMMON
#define DN_COMMON

#if defined(__cplusplus)
#define DN_EXTERN extern "C"
#else
#define DN_EXTERN extern
#endif

#if !defined(DN_VISIBLE)
#define DN_VISIBLE __declspec(dllexport)
#endif

#if !defined(DN_EXPORT)
#define DN_EXPORT DN_EXTERN DN_VISIBLE
#endif

#endif