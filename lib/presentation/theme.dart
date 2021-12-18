import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {

  static const Color primaryColor = Color(0xff1f3ef0);
  static const Color secondaryColor = Color(0xff081978);
  static const Color primaryTextColor = Colors.white;

  static ThemeData lightTheme = ThemeData(
    appBarTheme: const AppBarTheme(
      color: primaryColor,
    ),
    textTheme: GoogleFonts.rubikTextTheme().apply(
      bodyColor: primaryTextColor,
      displayColor: primaryTextColor,
    ),
    canvasColor: primaryColor,
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Colors.white,
    ),
  );

}