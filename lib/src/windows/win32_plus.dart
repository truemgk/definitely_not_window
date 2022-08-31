// ignore_for_file: non_constant_identifier_names

import 'dart:ui';

import 'package:win32/win32.dart' hide Rect, Size;

extension RECTtoRect on RECT {
  Rect get toRect => Rect.fromLTRB(
      left.toDouble(), top.toDouble(), right.toDouble(), bottom.toDouble());
}

extension SIZEtoSize on SIZE {
  Size get toSize => Size(cx.toDouble(), cy.toDouble());
}
