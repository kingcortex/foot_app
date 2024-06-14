import 'package:flutter/material.dart';
import 'package:football_app/utils/theme/custom_themes/appbar_theme.dart';
import 'package:football_app/utils/theme/custom_themes/elevated_button_theme.dart';
import 'package:football_app/utils/theme/custom_themes/text_theme.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.light,
    primaryColor: const Color(0xffffffff),
    scaffoldBackgroundColor: Color.fromARGB(255, 235, 232, 232),
    textTheme: MyTextTheme.lightTextTheme,
    appBarTheme: MyAppBarTheme.lightAppBarTheme,
    elevatedButtonTheme: MyElevationButtonTheme.lightElevationButtonTheme,
  );
  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'Poppins',
    brightness: Brightness.dark,
    primaryColor: const Color(0xff1f1f27),
    scaffoldBackgroundColor: const Color(0xff1f1f27),
    textTheme: MyTextTheme.darkTextTheme,
    appBarTheme: MyAppBarTheme.darkAppBarTheme,
    elevatedButtonTheme: MyElevationButtonTheme.darkElevationButtonTheme,
  );
}
