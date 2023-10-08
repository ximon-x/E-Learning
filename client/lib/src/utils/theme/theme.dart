import 'package:client/src/utils/theme/widget_themes.dart/text_theme.dart';
import 'package:flutter/material.dart';

class XAppTheme {
  // This class is not meant to be instantiated or extended; this constructor
  XAppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    textTheme: XTextTheme.lightTextTheme,
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    textTheme: XTextTheme.darkTextTheme,
  );
}
