import 'package:flutter/material.dart';

class AppTheme {
  // Define the primary color from the hex code EBD9D1
  static const Color _primaryColor = Color(0xFFEBD9D1);
  static const Color _accentColor = Color(0xFF212121); // A complementary color for buttons

  static final ThemeData lightTheme = ThemeData(
    // SET THE DEFAULT FONT FOR THE ENTIRE APP
    fontFamily: 'PlayfairDisplay',

    scaffoldBackgroundColor: Colors.white,
    primaryColor: _primaryColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: _accentColor,
      secondary: _accentColor,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Colors.black),
      // App bar title will also use the new font
      titleTextStyle: TextStyle(fontFamily: 'PlayfairDisplay', color: Colors.black, fontSize: 22, fontWeight: FontWeight.bold),
    ),

    // Style for ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _accentColor,
        foregroundColor: Colors.white,
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        // Button text will also use the new font
        textStyle: const TextStyle(fontFamily: 'PlayfairDisplay', fontSize: 16, fontWeight: FontWeight.bold),
      ),
    ),

    // Style for TextFormFields
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[100],
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: _accentColor),
      ),
    ),
  );
}

