import 'package:flutter/material.dart';

class AppTheme {
  // Seeds — tweak these if you want different accent tones
  static const Color _seedLight = Color(0xFF006D77); // deep teal
  static const Color _seedDark = Color(0xFF00B4A6); // bright teal

  static const double _cornerRadius = 12.0;
  static const EdgeInsets _buttonPadding = EdgeInsets.symmetric(vertical: 14, horizontal: 20);

  static ThemeData get lightMode {
    final cs = ColorScheme.fromSeed(seedColor: _seedLight, brightness: Brightness.light);
    final base = Typography.material2021().black;
    final textTheme = base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w700, letterSpacing: -0.5),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w600),
      titleLarge: base.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w600),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 14, height: 1.45),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    );

    final inputFill = cs.surfaceVariant.withOpacity(0.06);

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        iconTheme: IconThemeData(color: cs.onSurface),
      ),
      cardTheme: CardTheme(
        color: cs.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          padding: _buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.primary,
          padding: _buttonPadding,
          side: BorderSide(color: cs.primary.withOpacity(0.12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary, padding: _buttonPadding),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(_cornerRadius), borderSide: BorderSide.none),
        floatingLabelStyle: TextStyle(color: cs.primary, fontWeight: FontWeight.w600),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cs.surface,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.onSurfaceVariant,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.surfaceVariant,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.secondary,
        foregroundColor: cs.onSecondary,
        elevation: 4,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: cs.surface,
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cs.secondaryContainer,
        selectedColor: cs.secondary,
        labelStyle: textTheme.labelLarge!,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      iconTheme: IconThemeData(color: cs.onSurfaceVariant),
      sliderTheme: SliderThemeData(activeTrackColor: cs.primary, thumbColor: cs.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }

  static ThemeData get darkMode {
    final cs = ColorScheme.fromSeed(seedColor: _seedDark, brightness: Brightness.dark);
    final base = Typography.material2021().white;
    final textTheme = base.copyWith(
      displayLarge: base.displayLarge?.copyWith(fontWeight: FontWeight.w800, letterSpacing: -0.5),
      headlineLarge: base.headlineLarge?.copyWith(fontWeight: FontWeight.w700),
      titleLarge: base.titleLarge?.copyWith(fontSize: 16, fontWeight: FontWeight.w700),
      bodyLarge: base.bodyLarge?.copyWith(fontSize: 14, height: 1.45),
      labelLarge: base.labelLarge?.copyWith(fontWeight: FontWeight.w700),
    );

    final inputFill = cs.surfaceVariant.withOpacity(0.12);

    return ThemeData(
      useMaterial3: true,
      colorScheme: cs,
      scaffoldBackgroundColor: cs.background,
      textTheme: textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: cs.surface,
        foregroundColor: cs.onSurface,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        iconTheme: IconThemeData(color: cs.onSurface),
      ),
      cardTheme: CardTheme(
        color: cs.surface,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: cs.primary,
          foregroundColor: cs.onPrimary,
          elevation: 0,
          padding: _buttonPadding,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: cs.onPrimary,
          padding: _buttonPadding,
          side: BorderSide(color: cs.onSurface.withOpacity(0.12)),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(_cornerRadius)),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(foregroundColor: cs.primary, padding: _buttonPadding),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: inputFill,
        contentPadding: const EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(_cornerRadius), borderSide: BorderSide.none),
        floatingLabelStyle: TextStyle(color: cs.primary, fontWeight: FontWeight.w600),
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: cs.surface,
        selectedItemColor: cs.primary,
        unselectedItemColor: cs.onSurfaceVariant,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
      ),
      snackBarTheme: SnackBarThemeData(
        backgroundColor: cs.surfaceVariant,
        behavior: SnackBarBehavior.floating,
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: cs.secondary,
        foregroundColor: cs.onSecondary,
        elevation: 4,
      ),
      dialogTheme: DialogTheme(
        backgroundColor: cs.surface,
        titleTextStyle: textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
        contentTextStyle: textTheme.bodyLarge,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      chipTheme: ChipThemeData(
        backgroundColor: cs.secondaryContainer,
        selectedColor: cs.secondary,
        labelStyle: textTheme.labelLarge!,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      iconTheme: IconThemeData(color: cs.onSurfaceVariant),
      sliderTheme: SliderThemeData(activeTrackColor: cs.primary, thumbColor: cs.primary),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );
  }
}
