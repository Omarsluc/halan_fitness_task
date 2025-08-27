import 'package:flutter/material.dart';
import 'colors.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.primaryColor,
        brightness: Brightness.light,
        primary: ColorsManager.primaryColor,
        secondary: ColorsManager.secondaryColor,
        surface: ColorsManager.defaultSurface,
        background: ColorsManager.backgroundSurface,
        error: ColorsManager.errorFill,
        onPrimary: ColorsManager.darkColor,
        onSecondary: Colors.white,
        onSurface: ColorsManager.defaultText,
        onBackground: ColorsManager.defaultText,
        onError: ColorsManager.errorOnFill,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorsManager.primaryColor.withOpacity(0.1),
        foregroundColor: ColorsManager.darkColor,
        titleTextStyle: TextStyle(
          color: ColorsManager.darkColor,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: ColorsManager.darkColor),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: ColorsManager.primaryColor.withOpacity(0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: Colors.white,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: ColorsManager.primaryColor.withOpacity(0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: ColorsManager.primaryColor.withOpacity(0.05),
        labelStyle: TextStyle(color: ColorsManager.darkColor),
        hintStyle: TextStyle(color: ColorsManager.greyColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          foregroundColor: ColorsManager.darkColor,
          elevation: 2,
          shadowColor: ColorsManager.primaryColor.withOpacity(0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: ColorsManager.primaryColor.withOpacity(0.2),
        labelTextStyle: MaterialStateProperty.all(
          TextStyle(
              color: ColorsManager.darkColor, fontWeight: FontWeight.w600),
        ),
        iconTheme: WidgetStateProperty.all(
          IconThemeData(color: ColorsManager.darkColor),
        ),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsManager.primaryColor,
        brightness: Brightness.dark,
        primary: ColorsManager.primaryColor,
        secondary: ColorsManager.secondaryColor,
        surface: ColorsManager.darkColor,
        background: ColorsManager.secondaryDarkColor,
        error: ColorsManager.errorFill,
        onPrimary: ColorsManager.darkColor,
        onSecondary: Colors.white,
        onSurface: ColorsManager.defaultTextSecondaryDark,
        onBackground: ColorsManager.defaultTextSecondaryDark,
        onError: ColorsManager.errorOnFill,
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: ColorsManager.primaryColor.withOpacity(0.15),
        foregroundColor: ColorsManager.defaultTextSecondaryDark,
        titleTextStyle: TextStyle(
          color: ColorsManager.defaultTextSecondaryDark,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(color: ColorsManager.defaultTextSecondaryDark),
      ),
      cardTheme: CardTheme(
        elevation: 4,
        shadowColor: ColorsManager.primaryColor.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: ColorsManager.darkColor,
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: ColorsManager.primaryColor.withOpacity(0.4)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide:
              BorderSide(color: ColorsManager.primaryColor.withOpacity(0.4)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorsManager.primaryColor, width: 2),
        ),
        filled: true,
        fillColor: ColorsManager.primaryColor.withOpacity(0.1),
        labelStyle: TextStyle(color: ColorsManager.defaultTextSecondaryDark),
        hintStyle: TextStyle(color: ColorsManager.greyColor),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: ColorsManager.primaryColor,
          foregroundColor: ColorsManager.darkColor,
          elevation: 2,
          shadowColor: ColorsManager.primaryColor.withOpacity(0.4),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: ColorsManager.darkColor,
        indicatorColor: ColorsManager.primaryColor.withOpacity(0.3),
        labelTextStyle: WidgetStateProperty.all(
          TextStyle(
              color: ColorsManager.defaultTextSecondaryDark,
              fontWeight: FontWeight.w600),
        ),
        iconTheme: MaterialStateProperty.all(
          IconThemeData(color: ColorsManager.defaultTextSecondaryDark),
        ),
      ),
    );
  }
}
