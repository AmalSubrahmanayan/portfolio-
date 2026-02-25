import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../constants/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      primaryColor: AppColors.primaryBlack,
      colorScheme: const ColorScheme.light(
        primary: AppColors.primaryBlack,
        secondary: AppColors.textSecondary,
        surface: AppColors.surfaceWhite,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 56,
          fontWeight: FontWeight.w800,
          letterSpacing: -1.0,
        ),
        displayMedium: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 40,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.5,
        ),
        headlineMedium: GoogleFonts.montserrat(
          color: AppColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.w700,
          letterSpacing: 2.0,
        ),
        titleLarge: GoogleFonts.lato(
          color: AppColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w700,
        ),
        bodyLarge: GoogleFonts.lato(
          color: AppColors.textSecondary,
          fontSize: 18,
          height: 1.6,
        ),
        bodyMedium: GoogleFonts.lato(
          color: AppColors.textSecondary,
          fontSize: 14,
          height: 1.5,
        ),
        bodySmall: GoogleFonts.lato(
          color: AppColors.textSecondary,
          fontSize: 12,
          height: 1.4,
        ),
      ),
      useMaterial3: true,
    );
  }
}
