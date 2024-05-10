import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Add this import statement

ThemeData lightMode = ThemeData(
  textTheme: GoogleFonts.outfitTextTheme(),
  colorScheme: ColorScheme.light(
    background: const Color(0xFFF1F4F8),
    primary: const Color(0xFF222DD2),
    primaryContainer: const Color.fromARGB(255, 29, 38, 172),
    secondary: const Color(0xFFFFFFFF),
    tertiary: const Color(0xFFFFD127),
    inversePrimary: const Color.fromARGB(255, 0, 0, 0),
    shadow: Color.fromARGB(255, 155, 155, 155),
    outline: const Color(0xFF3B5578), // Define the new color here
    scrim: const Color(0xFF5F7A9F),
    surfaceTint: const Color(0xFF39D2C0)

  )
);


ThemeData darkMode = ThemeData(
  textTheme: GoogleFonts.outfitTextTheme(),
  colorScheme: ColorScheme.dark(
    background: Colors.grey.shade900,
    primary: Colors.grey.shade500,
    secondary: Colors.grey.shade800,
    tertiary: Colors.grey.shade800,
    inversePrimary: Colors.grey.shade300,
  ),
);
