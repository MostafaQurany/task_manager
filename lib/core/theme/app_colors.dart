import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Main brand
  static const Color primary = Color(0xFFFFB08A);
  static const Color primaryLight = Color(0xFFFFD4BF);
  static const Color primaryDark = Color(0xFFC98468);

  // Backgrounds
  static const Color background = Color(0xFF0A0B0D);
  static const Color backgroundDeep = Color(0xFF030304);
  static const Color navyDark = Color(0xFF111827);

  // Surfaces
  static const Color surface = Color(0xFF1D1D1D);
  static const Color surfaceSoft = Color(0xFF242526);
  static const Color surfaceLight = Color(0xFF303134);
  static const Color surfaceCard = Color(0xFF202124);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFA7A7A7);
  static const Color textMuted = Color(0xFF6F7074);
  static const Color textDark = Color(0xFF111111);

  // Cards / accents
  static const Color lightBlueCard = Color(0xFFE5F6FA);
  static const Color lightGreenCard = Color(0xFFEFFFBA);
  static const Color whiteCard = Color(0xFFF8F8F8);

  // Status
  static const Color success = Color(0xFF8CFF7A);
  static const Color danger = Color(0xFFFF6B6B);
  static const Color warning = Color(0xFFFFC46B);

  // Borders
  static const Color border = Color(0xFF3A3A3A);
  static const Color borderLight = Color(0xFFE8E8E8);

  static const LinearGradient mainGradient = LinearGradient(
    end: AlignmentDirectional.bottomStart,
    begin: AlignmentDirectional.topCenter,
    colors: [
      primary,
      Color(0xFF14161E),
      Color(0xFF08090D),
      Color(0xFF000000),
      Color(0xFF17191D),
    ],
    stops: [0.0, 0.25, 0.52, 0.78, 1.0],
  );

  static const LinearGradient softPeachGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFFFFC5A8),
      Color(0xFFB98775),
      Color(0xFF111827),
      Colors.black,
    ],
    stops: [0.0, 0.18, 0.45, 1.0],
  );

  static const LinearGradient darkCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2A2A2B), Color(0xFF111111)],
  );
}
