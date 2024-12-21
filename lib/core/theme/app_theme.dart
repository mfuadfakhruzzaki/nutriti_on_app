// lib/core/theme/app_theme.dart
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  // Tema Terang
  static final lightTheme = ThemeData(
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.lightBackground,
    brightness: Brightness.light,
    fontFamily: 'Plus Jakarta Sans', // Ditetapkan oleh google_fonts
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.light().textTheme.copyWith(
            displayLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            displayMedium: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            bodyLarge: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            titleMedium: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            titleSmall: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            labelLarge: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
    colorScheme: ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      error: AppColors.error,
      background: AppColors.lightBackground,
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.primary,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks tombol
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.4,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.black,
          width: 0.4,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.white,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.white,
      shadowColor: Colors.black12,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primary,
      contentTextStyle: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.primary,
      size: 24,
    ),
    // Tema lainnya seperti checkbox, switch, dll., dapat ditambahkan di sini
  );

  // Tema Gelap
  static final darkTheme = ThemeData(
    primaryColor: AppColors.primaryDark,
    scaffoldBackgroundColor: AppColors.darkBackground,
    brightness: Brightness.dark,
    fontFamily: 'Plus Jakarta Sans', // Ditetapkan oleh google_fonts
    textTheme: GoogleFonts.plusJakartaSansTextTheme(
      ThemeData.dark().textTheme.copyWith(
            displayLarge: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            displayMedium: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            bodyLarge: const TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
            bodyMedium: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            titleMedium: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
            ),
            titleSmall: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            labelLarge: const TextStyle(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
    ),
    colorScheme: ColorScheme.dark(
      primary: AppColors.primaryDark,
      secondary: AppColors.accent,
      error: AppColors.error,
      background: AppColors.darkBackground,
      surface: AppColors.darkGrey,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onError: Colors.white,
      onBackground: AppColors.textPrimary,
      onSurface: AppColors.textPrimary,
    ),
    appBarTheme: AppBarTheme(
      color: AppColors.primaryDark,
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      titleTextStyle: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryDark, // Warna latar belakang tombol
        foregroundColor: Colors.white, // Warna teks tombol
        textStyle: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.transparent,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      hintStyle: GoogleFonts.plusJakartaSans(
        color: AppColors.textSecondary,
        fontWeight: FontWeight.w500,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.4,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(30),
        borderSide: const BorderSide(
          color: Colors.white,
          width: 0.4,
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.accent,
      foregroundColor: Colors.black,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
    ),
    cardTheme: CardTheme(
      color: AppColors.darkGrey,
      shadowColor: Colors.black54,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: AppColors.primaryDark,
      contentTextStyle: GoogleFonts.plusJakartaSans(
        color: Colors.white,
        fontSize: 16,
      ),
    ),
    iconTheme: const IconThemeData(
      color: AppColors.accent,
      size: 24,
    ),
    // Tema lainnya seperti checkbox, switch, dll., dapat ditambahkan di sini
  );
}
