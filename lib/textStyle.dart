import 'package:flutter/material.dart';

class Style {
  static final baseTextStyle = const TextStyle(fontFamily: 'Arial');

  static final appBar = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);

  static final textApp = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.w600);
  static final textAppTitulo = baseTextStyle.copyWith(
      color: Colors.black, fontSize: 25.0, fontWeight: FontWeight.w600);
}
