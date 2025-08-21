import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors - More sophisticated palette
  static const Color primary = Color(0xFF6C63FF);     // Rich purple
  static const Color secondary = Color(0xFFFF6584);    // Soft pink

  // Background Colors - Richer dark theme
  static const Color scaffoldBackground = Color(0xFF0A1929);  // Deep navy
  static const Color surface = Color(0xFF132F4C);     // Lighter navy
  static const Color cardBackground = Color(0xFF1E3A5F);  // Mixed blue-gray
  static const Color cardBackgroundAlt = Color(0xFF162C45);  // Alternative card background
  static const Color cardBorder = Color(0x33FFFFFF);  // 20% white opacity

  // Text Colors - Improved contrast
  static const Color textPrimary = Color(0xFFF5F9FF);  // Slightly off-white
  static const Color textSecondary = Color(0xE6E3E8FF);  // Light purple tint
  static const Color textTertiary = Color(0xCCD1D7FF);   // Subtle blue tint

  // Accent Colors - Expanded palette
  static const Color accentBlue = Color(0xFF61DAFB);    // React blue
  static const Color accentYellow = Color(0xFFFFC837);   // Warm yellow
  static const Color accentOrange = Color(0xFFFF7C51);   // Coral orange
  static const Color accentRed = Color(0xFFFF5757);      // Soft red
  static const Color accentGreen = Color(0xFF4CAF50);    // Material green
  static const Color accentPurple = Color(0xFF7C4DFF);   // Deep purple
  static const Color accentPink = Color(0xFFE91E63);     // Material pink
  static const Color accentTeal = Color(0xFF009688);     // Teal

  // Gradient Colors - Enhanced with more options
  static const Color gradientStart = Color(0xFF8B5CF6);  // Purple
  static const Color gradientEnd = Color(0xFFEC4899);    // Pink

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [gradientStart, gradientEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const List<Color> accentGradient = [accentPurple, accentPink];
  static const List<Color> coolGradient = [accentBlue, accentTeal];
  static const List<Color> warmGradient = [accentOrange, accentYellow];
  static const List<Color> cardGradient = [cardBackground, cardBackgroundAlt];

  // Effect Colors
  static const Color glowOverlay = Color(0x1A6C63FF);  // Purple glow
  static const Color overlay = Color(0x0AFFFFFF);      // Subtle white overlay

  // Color with alpha helpers
  static Color withAlpha(Color color, double alpha) {
    return color.withAlpha((alpha * 255).round());
  }
}
