import 'package:flutter/material.dart';
import 'package:skitoboxes/constants/colors.dart';

ThemeData myTheme = ThemeData(
  primaryTextTheme: const TextTheme(
    headline5: TextStyle(
      fontFamily: 'Akira',
      fontSize: 24,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(
      fontFamily: 'Avenir',
      fontSize: 14,
      color: Colors.black,
    ),
  ),
  primarySwatch: const MaterialColor(0xFFFFB703, color),
  primaryColor: yellow,
  accentColor: orange,
  scaffoldBackgroundColor: Colors.white,
  cardColor: blue,
  dividerColor: lightBlue,
  focusColor: yellow,
  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      primary: darkBlue,
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      onPrimary: Colors.white,
      primary: orange,
    ),
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: orange,
    ),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: orange,
    elevation: 5
  )
);