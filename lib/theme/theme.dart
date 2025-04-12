import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme(
    brightness: Brightness.light,
    primary: Colors.indigo.shade800,
    onPrimary: Colors.white,
    secondary: const Color.fromARGB(255, 41, 65, 144),
    onSecondary: Colors.white,
    error: Colors.red.shade700,
    onError: const Color.fromARGB(255, 199, 26, 26),
    surface: Colors.grey.shade100,
    onSurface: Colors.black87,
  ),
  scaffoldBackgroundColor: Colors.grey.shade50,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 54,
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
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.quicksand(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    ),
  ),
);

ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme(
    brightness: Brightness.dark,
    primary: const Color.fromARGB(255, 92, 124, 228),
    onPrimary: Colors.white,
    secondary: const Color.fromARGB(255, 92, 124, 228),
    onSecondary: Colors.white,
    error: Colors.red.shade300,
    onError: Colors.red.shade200,
    surface: Colors.grey.shade900,
    onSurface: Colors.white70,
  ),
  scaffoldBackgroundColor: Colors.black,
  textTheme: TextTheme(
    displayLarge: GoogleFonts.quicksand(
      fontSize: 54,
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
      fontSize: 22,
      fontWeight: FontWeight.w500,
    ),
    bodyMedium: GoogleFonts.quicksand(
      fontSize: 18,
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
