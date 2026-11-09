import 'package:flutter/material.dart';

const Color white = Colors.white;
const primaryClr = Colors.teal;
const Color darkGreyClr = Color(0xFF121212);
const successColor = Colors.green;
const errorColor = Colors.red;

final theme = ThemeData(
  brightness: Brightness.light,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    backgroundColor: primaryClr,
    elevation: 0,
    titleTextStyle: TextStyle(fontSize: 20, color: darkGreyClr),
  ),
  colorSchemeSeed: primaryClr,
  scaffoldBackgroundColor: white,
  secondaryHeaderColor: white,
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: primaryClr,
    foregroundColor: darkGreyClr,
  ),
  textButtonTheme: TextButtonThemeData(
    style: ButtonStyle(
      foregroundColor: WidgetStateProperty.all(darkGreyClr),
      overlayColor: WidgetStateProperty.all(Colors.transparent),
    ),
  ),
);
