import 'package:flutter/material.dart';

class AppTheme {
  // Define the new theme colors
  static const Color _backgroundColor = Color(0xFF1DB954);
  static const Color _buttonColor = Colors.black;
  static const Color _buttonTextColor = Colors.white;

  static final ThemeData lightTheme = ThemeData(
    // SET THE DEFAULT FONT FOR THE ENTIRE APP
    fontFamily: 'PlayfairDisplay',

    // SET THE NEW SCAFFOLD BACKGROUND COLOR
    scaffoldBackgroundColor: _backgroundColor,

    primaryColor: _backgroundColor,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      primary: _buttonColor, // Used for various accents
      secondary: _buttonColor,
      background: _backgroundColor,
      surface: Colors.white, // Color for Cards, Dialogs, etc.
    ),

    // --- MODIFIED App Bar Theme ---
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent, // Make AppBar transparent
      elevation: 0, // Remove shadow
      iconTheme: IconThemeData(color: Colors.white), // Make icons (like back arrow) white
      titleTextStyle: TextStyle(
          fontFamily: 'PlayfairDisplay',
          color: Colors.white, // Make title text white
          fontSize: 22,
          fontWeight: FontWeight.bold),
    ),
    // --- END MODIFICATION ---

    // Style for ElevatedButtons
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: _buttonColor, // Updated button color
        foregroundColor: _buttonTextColor, // Updated button text color
        shape: const StadiumBorder(),
        padding: const EdgeInsets.symmetric(vertical: 16),
        textStyle: const TextStyle(
            fontFamily: 'PlayfairDisplay',
            fontSize: 16,
            fontWeight: FontWeight.bold),
      ),
    ),

    // Style for TextFormFields (remains the same)
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
        borderSide: const BorderSide(color: _buttonColor),
      ),
    ),
  );
}