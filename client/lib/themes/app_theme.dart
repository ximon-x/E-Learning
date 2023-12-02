import 'package:flutter/material.dart';
import 'package:iLearn/themes/text_theme.dart';

class XAppTheme {
  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: XTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: XTextTheme.darkTextTheme,
  );

  // This class is not meant to be instantiated or extended; this constructor
  XAppTheme._();
}
