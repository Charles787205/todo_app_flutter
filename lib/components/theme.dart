import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

final ThemeData theme = ThemeData(
  fontFamily: GoogleFonts.montserrat().fontFamily,
  textTheme: const TextTheme().apply(
      fontFamily: GoogleFonts.montserrat().fontFamily,
      bodyColor: const Color.fromRGBO(252, 184, 21, 1)),
  colorScheme: const ColorScheme.dark(
      background: Color.fromRGBO(62, 62, 62, 1),
      brightness: Brightness.dark,
      primary: Color.fromRGBO(252, 184, 21, 1),
      secondary: Color.fromRGBO(217, 217, 217, 1),
      tertiary: Color.fromRGBO(42, 42, 42, 1),
      onSurface: Color.fromRGBO(252, 184, 21, 1),
      onBackground: Color.fromRGBO(252, 184, 21, 1)),
  appBarTheme: const AppBarTheme(
      backgroundColor: Color.fromRGBO(42, 42, 42, 1),
      iconTheme: IconThemeData(color: Color.fromRGBO(252, 184, 21, 1))),
);
