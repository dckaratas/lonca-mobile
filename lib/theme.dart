import 'package:flutter/material.dart';

/// Lonca renk paleti (web paneliyle aynı).
class LoncaColors {
  static const night = Color(0xFF0B0907);
  static const coal = Color(0xFF120D0A);
  static const umber = Color(0xFF1A130D);
  static const bronze = Color(0xFF5A4424);
  static const bronzeLight = Color(0xFF7A5C2E);
  static const goldDark = Color(0xFFB08D3C);
  static const gold = Color(0xFFD4A94F);
  static const goldPale = Color(0xFFEBD39A);
  static const bone = Color(0xFFE8DCC0);
  static const ash = Color(0xFFA8987A);
  static const parchment = Color(0xFFEFE4C8);
  static const ink = Color(0xFF2B1D12);

  /// Koyu kutu (kart) dekorasyonu.
  static BoxDecoration box({Color border = bronze, double radius = 5}) => BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Color(0xCC1A130D), Color(0xEE0B0907)],
        ),
        boxShadow: const [BoxShadow(color: Color(0x66000000), blurRadius: 24, offset: Offset(0, 8))],
      );
}

ThemeData buildLoncaTheme() {
  final base = ThemeData(
    brightness: Brightness.dark,
    useMaterial3: true,
    colorScheme: const ColorScheme.dark(
      primary: LoncaColors.gold,
      onPrimary: LoncaColors.ink,
      secondary: LoncaColors.goldPale,
      surface: LoncaColors.umber,
      onSurface: LoncaColors.bone,
      outline: LoncaColors.bronze,
    ),
  );

  return base.copyWith(
    scaffoldBackgroundColor: LoncaColors.night,
    textTheme: base.textTheme.apply(
      bodyColor: LoncaColors.bone,
      displayColor: LoncaColors.goldPale,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: LoncaColors.coal,
      foregroundColor: LoncaColors.goldPale,
      centerTitle: true,
      elevation: 0,
      shape: Border(bottom: BorderSide(color: LoncaColors.bronze)),
      titleTextStyle: TextStyle(
        fontSize: 18,
        letterSpacing: 2.4,
        color: LoncaColors.goldPale,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: LoncaColors.coal,
      hintStyle: const TextStyle(color: LoncaColors.ash),
      prefixIconColor: LoncaColors.ash,
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: LoncaColors.bronze),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: const BorderSide(color: LoncaColors.gold),
      ),
    ),
    chipTheme: ChipThemeData(
      backgroundColor: LoncaColors.coal,
      selectedColor: LoncaColors.gold.withValues(alpha: 0.18),
      checkmarkColor: LoncaColors.gold,
      side: const BorderSide(color: LoncaColors.bronze),
      labelStyle: const TextStyle(color: LoncaColors.bone, fontSize: 15),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: LoncaColors.gold.withValues(alpha: 0.12),
        foregroundColor: LoncaColors.goldPale,
        disabledBackgroundColor: LoncaColors.coal,
        disabledForegroundColor: LoncaColors.ash,
        side: const BorderSide(color: LoncaColors.gold),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle: const TextStyle(letterSpacing: 1.6, fontSize: 15),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: LoncaColors.parchment,
      contentTextStyle: TextStyle(color: LoncaColors.ink, fontSize: 16),
    ),
    badgeTheme: const BadgeThemeData(backgroundColor: LoncaColors.gold, textColor: LoncaColors.ink),
    progressIndicatorTheme: const ProgressIndicatorThemeData(color: LoncaColors.gold),
    iconTheme: const IconThemeData(color: LoncaColors.gold),
  );
}
