import 'package:flutter/material.dart';

class VoyentaColors {
  // Brand Primary & Secondary
  static const Color primary = Color(0xFF4F378A);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF6750A4);
  static const Color onPrimaryContainer = Color(0xFFE0D2FF);
  
  static const Color secondary = Color(0xFF63597C);
  static const Color secondaryContainer = Color(0xFFE1D4FD);
  static const Color onSecondaryContainer = Color(0xFF645A7D);

  static const Color tertiary = Color(0xFF765B00);
  static const Color tertiaryContainer = Color(0xFFC9A74D);
  static const Color onTertiaryContainer = Color(0xFF503D00);

  // Voyager Gradient
  static const Color voyagerStart = Color(0xFF2563EB); // Deep Sapphire
  static const Color voyagerEnd = Color(0xFF06B6D4);   // Vibrant Cyan
  
  static const Gradient voyagerGradient = LinearGradient(
    colors: [voyagerStart, voyagerEnd],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Surfaces & Backgrounds
  static const Color background = Color(0xFFFDF7FF);
  static const Color onBackground = Color(0xFF1D1B20);

  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceDim = Color(0xFFDED8E0);
  static const Color surfaceBright = Color(0xFFFDF7FF);
  
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFF8F2FA);
  static const Color surfaceContainer = Color(0xFFF2ECF4);
  static const Color surfaceContainerHigh = Color(0xFFECE6EE);
  static const Color surfaceContainerHighest = Color(0xFFE6E0E9);

  static const Color onSurface = Color(0xFF1D1B20);
  static const Color onSurfaceVariant = Color(0xFF494551);
  
  static const Color inverseSurface = Color(0xFF322F35);
  static const Color inverseOnSurface = Color(0xFFF5EFF7);

  static const Color outline = Color(0xFF7A7582);
  static const Color outlineVariant = Color(0xFFCBC4D2);

  // Semantic/Functional (Safety Indicators)
  static const Color emerald = Color(0xFF10B981); // Secure
  static const Color amber = Color(0xFFF59E0B);   // Caution/Scam
  static const Color rose = Color(0xFFEF4444);    // High Risk

  // Error Colors
  static const Color error = Color(0xFFBA1A1A);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Fixed Colors (Material You tonal palette)
  static const Color primaryFixed = Color(0xFFE9DDFF);
  static const Color primaryFixedDim = Color(0xFFCFBCFF);
  static const Color tertiaryFixed = Color(0xFFE8DEF9);

  // Legacy alias
  static const Color surfaceVariant = Color(0xFFE6E0E9);
}
