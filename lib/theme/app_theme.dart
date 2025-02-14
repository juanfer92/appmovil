import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.green,
    scaffoldBackgroundColor: Colors.white,
    textTheme: TextTheme(
      titleLarge:
          GoogleFonts.poppins(fontSize: 20, fontWeight: FontWeight.bold),
      bodyMedium: GoogleFonts.poppins(fontSize: 16),
    ),
    colorScheme: ColorScheme.light(
      primary: Colors.green,
      secondary: Colors.lightGreen,
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.green,
      elevation: 0,
      titleTextStyle: GoogleFonts.poppins(fontSize: 20, color: Colors.white),
    ),
  );
}
