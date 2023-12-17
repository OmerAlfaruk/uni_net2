import 'package:flutter/material.dart';
import 'package:uni_link/utils/theme/widget_theme/Button_theme.dart';
import 'package:uni_link/utils/theme/widget_theme/text_form_theme.dart';
import 'package:uni_link/utils/theme/widget_theme/text_themes.dart';




class OAppTheme {
  OAppTheme._();


  static ThemeData lightTheme = ThemeData(

    primarySwatch: Colors.blue,

    brightness: Brightness.light,
    textTheme: OTextTheme.lightTextTheme,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(),
    elevatedButtonTheme: OElevatedButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: OOutLinedButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: OTextFormTheme.lightInputDecoration,


  );


  static ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
    textTheme: OTextTheme.darkTextTheme,
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
  outlinedButtonTheme: OOutLinedButtonTheme.darkOutlinedButtonTheme,
      elevatedButtonTheme: OElevatedButtonTheme.darkElevatedButtonTheme,
    inputDecorationTheme: OTextFormTheme.darkInputDecoration
  );

}