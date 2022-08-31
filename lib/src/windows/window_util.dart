import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:win32/win32.dart';

const dnwAction = 0x7FFE;

const dnwSetWindowPos = 1;
const dnwSetWindowText = 2;
const dnwForceRefresh = 3;

class SWPParam extends Struct {
  @Int32()
  external int x, y, cx, cy, uFlags;
}

void setWindowPos(
    int hWnd, int hWndInsertAfter, int x, int y, int cx, int cy, int uFlags) {
  final param = calloc<SWPParam>();
  param.ref
    ..x = x
    ..y = y
    ..cx = cx
    ..cy = cy
    ..uFlags = uFlags;
  PostMessage(hWnd, dnwAction, dnwSetWindowPos, param.address);
}

class SWTParam extends Struct {
  external Pointer<Utf16> text;
}

void setWindowText(int hWnd, String text) {
  final param = calloc<SWTParam>();
  param.ref.text = text.toNativeUtf16();
  PostMessage(hWnd, dnwAction, dnwSetWindowText, param.address);
}

void forceChildRefresh(int hWnd) {
  PostMessage(hWnd, dnwAction, dnwForceRefresh, 0);
}
