import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor =
      Color(0xFF6750A4); // Color morado en tendencia
  static const Color secondaryColor = Color(0xFF625B71);
  static const Color errorColor = Color(0xFFB3261E);
  static const Color backgroundColor = Color(0xFFEEEFFF);

  static TextStyle get headline1 => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: primaryColor,
      );

  static TextStyle get headline2 => TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      );

  static TextStyle get bodyText1 => TextStyle(
        fontSize: 16,
        color: secondaryColor,
      );

  static InputDecoration get inputDecoration => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: secondaryColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: primaryColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(color: errorColor),
        ),
      );

  static ButtonStyle get elevatedButtonStyle => ElevatedButton.styleFrom(
        backgroundColor: primaryColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        textStyle: TextStyle(fontSize: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      );
}
