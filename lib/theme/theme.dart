import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.indigo.shade200,
    onPrimary: Colors.white,
    secondary: const Color.fromARGB(255, 224, 144, 39),
    onSecondary: Colors.black87,
    error: Colors.red.shade300,
    onError: Colors.red.shade900,
    surface: Colors.grey.shade100,
    onSurface: Colors.black87,
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 64,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.quicksand(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: Colors.indigo.shade800,
    onPrimary: Colors.white,
    secondary: Colors.deepOrange.shade300,
    onSecondary: Colors.black,
    error: Colors.red.shade700,
    onError: Colors.red.shade200,
    surface: Colors.grey.shade900,
    onSurface: Colors.white70,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 64,
      fontWeight: FontWeight.w700,
    ),
    displayMedium: GoogleFonts.quicksand(
      fontSize: 32,
      fontWeight: FontWeight.w700,
    ),
    displaySmall: GoogleFonts.quicksand(
      fontSize: 24,
      fontWeight: FontWeight.w600,
    ),
    bodyLarge: GoogleFonts.quicksand(
      fontSize: 20,
      fontWeight: FontWeight.w500,
    ),
  ),
);

// i decided to add few more colors with extending the color scheme
extension CustomColors on ColorScheme {
  Color get ratingLow => Colors.red.shade500;
  Color get ratingMedium => const Color.fromARGB(255, 206, 189, 45);
  Color get ratingHigh => Colors.green.shade500;
}
