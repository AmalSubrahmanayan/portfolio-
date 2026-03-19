import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const Color backgroundLight = Color(0xFFEEEEEE); // Light grey background
  static const Color backgroundDark = Color(0xFF111111); // Dark background for split sections
  static const Color surfaceWhite = Color(0xFFFFFFFF); // White surfaces
  static const Color primaryBlack = Color(0xFF000000); // Main black accent
  static const Color textPrimary = Color(0xFF000000); // Black reading text for light bg
  static const Color textPrimaryLight = Color(0xFFFFFFFF); // White reading text for dark bg
  static const Color textSecondary = Color(0xFF757575); // Grey text
  
  // Neon Colors for Mobile App Layout
  static const Color neonBlue = Color(0xFF2DE1FC);
  static const Color neonPurple = Color(0xFF8A2BE2);
  static const Color neonPink = Color(0xFFFF007F);
  
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFFEEEEEE), Color(0xFFE0E0E0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient neonGradient = LinearGradient(
    colors: [neonBlue, neonPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient textGlowGradient = LinearGradient(
    colors: [neonBlue, neonPink],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );
}
