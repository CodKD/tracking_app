import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

abstract class AppTheme {
  static ThemeData getTheme({
    required ColorScheme colorScheme,
    required Color textFormFieldBorderColor,
  }) {
    return ThemeData(
      colorScheme: colorScheme,
      appBarTheme: const AppBarTheme(
        centerTitle: false,
        backgroundColor: AppColors.white,
        foregroundColor: AppColors.black,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        selectedItemColor: AppColors.pink,
        unselectedItemColor: AppColors.grey,
        elevation: 0,
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(18),
          backgroundColor: AppColors.pink,
          foregroundColor: AppColors.white,
          disabledBackgroundColor: AppColors.grey,
          disabledForegroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),

      inputDecorationTheme: InputDecorationTheme(
        fillColor: AppColors.white,
        filled: true,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(4)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: textFormFieldBorderColor, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: textFormFieldBorderColor, width: 1),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: BorderSide(color: colorScheme.error, width: 1),
        ),
      ),

      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.all(16),
          disabledBackgroundColor: AppColors.grey,
          backgroundColor: colorScheme.primary,
          foregroundColor: AppColors.white,
          disabledForegroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
      ),
      textTheme: TextTheme(
        titleMedium: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.imFellEnglish().fontFamily,
        ),
        bodyMedium: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
        ),
        bodyLarge: TextStyle(
          fontSize: 18.sp,
          fontWeight: FontWeight.w500,
          fontFamily: GoogleFonts.inter().fontFamily,
          color: AppColors.black[500],
        ),
      ),
    );
  }

  static ThemeData lightTheme = getTheme(
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.pink,
      onPrimary: AppColors.white,
      secondary: AppColors.black,
      onSecondary: AppColors.white,
      error: AppColors.red,
      onError: AppColors.white,
      surface: AppColors.white,
      onSurface: AppColors.black,
    ),
    textFormFieldBorderColor: AppColors.grey,
  );
}
