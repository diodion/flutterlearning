import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue.shade900,
          brightness: Brightness.light,
        ),
        primaryColor: Colors.blue.shade900,
        scaffoldBackgroundColor: Colors.grey.shade300,
        textTheme: GoogleFonts.firaSansTextTheme(
          ThemeData.light().textTheme.copyWith(
                displayLarge: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                displayMedium: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                displaySmall: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                headlineMedium: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                headlineSmall: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                titleLarge: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w500, color: Colors.grey.shade900),
                bodyLarge: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w300, color: Colors.grey.shade900),
                bodyMedium: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w300, color: Colors.grey.shade900),
                bodySmall: GoogleFonts.firaSans(
                    fontWeight: FontWeight.w300, color: Colors.grey.shade900),
              ),
        ),
        hoverColor: Colors.blue.shade800,
        focusColor: Colors.blue.shade800,
        highlightColor: Colors.blue.shade800,
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: Colors.grey.shade900,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(3),
            borderSide: BorderSide(
              color: Colors.blue.shade800,
            ),
          ),
          prefixIconColor: WidgetStateColor.resolveWith((states) =>
              states.contains(WidgetState.focused)
                  ? Colors.blue.shade800
                  : Colors.grey.shade900),
          hintStyle: TextStyle(
            color: Colors.grey.shade900,
          ),
        ),
        dialogTheme: DialogTheme(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(3),
          ),
          actionsPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        ));
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue.shade900,
        brightness: Brightness.dark,
      ),
      primaryColor: Colors.blue.shade900,
      scaffoldBackgroundColor: Colors.grey.shade900,
      textTheme: GoogleFonts.firaSansTextTheme(
        ThemeData.dark().textTheme.copyWith(
              displayLarge: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              displayMedium: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              displaySmall: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              headlineMedium: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              headlineSmall: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              titleLarge: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w500, color: Colors.white),
              bodyLarge: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w300, color: Colors.white),
              bodyMedium: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w300, color: Colors.white),
              bodySmall: GoogleFonts.firaSans(
                  fontWeight: FontWeight.w300, color: Colors.white),
            ),
      ),
      hoverColor: Colors.blue.shade800,
      focusColor: Colors.blue.shade800,
      highlightColor: Colors.blue.shade800,
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(
            color: Colors.grey.shade100,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(3.0),
          borderSide: BorderSide(
            color: Colors.blue.shade800,
          ),
        ),
        // Muda a cor do icone qnd selecionado.
        prefixIconColor: WidgetStateColor.resolveWith((states) =>
            states.contains(WidgetState.focused)
                ? Colors.blue.shade800
                : Colors.grey.shade100),
        hintStyle: TextStyle(
          color: Colors.grey.shade100,
        ),
      ),
      dialogTheme: DialogTheme(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(3),
        ),
        actionsPadding:
            const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      ),
    );
  }
}
