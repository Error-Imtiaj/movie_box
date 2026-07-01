import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movie_box/core/const/app_size.dart';

import '../const/app_colors.dart';

class AppTheme {
  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.scaffoldBackgroundColor,

    colorScheme: ColorScheme.light(
      primary: AppColors.buttonBackgroundColor,
      secondary: AppColors.buttonBackgroundColor,
      surface: AppColors.cardColor,
      error: AppColors.error,
    ),

    //==========================================================================
    // Font
    //==========================================================================
    textTheme: TextTheme(
      /// Large screen title.
      /// Example: Movie Details, Profile
      displayLarge: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeExtraExtraLarge.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),

      /// Section title.
      /// Example: Trending, Popular, Continue Watching
      headlineLarge: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeExtraLarge.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.textColor,
      ),

      /// AppBar title.
      headlineMedium: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeLarge.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),

      /// Movie title.
      titleLarge: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeMediumLarge.sp,
        fontWeight: FontWeight.w700,
        color: AppColors.textColor,
      ),

      /// Card title.
      titleMedium: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeMedium.sp,
        fontWeight: FontWeight.w600,
        color: AppColors.textColor,
      ),

      /// Subtitle.
      /// Example: Genre, Release Date
      titleSmall: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeSmallMedium.sp,
        fontWeight: FontWeight.w500,
        color: AppColors.subtitleColor,
      ),

      /// Button text.
      labelLarge: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeSmallMedium.sp,
        fontWeight: FontWeight.bold,
        color: AppColors.white,
      ),

      /// Normal body text.
      bodyLarge: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeSmallMedium.sp,
        color: AppColors.textColor,
      ),

      /// Description.
      /// Example: Movie Overview
      bodyMedium: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeSmall.sp,
        color: AppColors.subtitleColor,
        height: 1.5.h,
      ),

      /// Caption.
      /// Example: Rating, Duration
      bodySmall: TextStyle(
        fontFamily: 'Sansita',
        fontSize: AppSize.fontSizeSmall.sp,
        color: AppColors.subtitleColor,
      ),
    ),

    //==========================================================================
    // AppBar
    //==========================================================================
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: AppColors.scaffoldBackgroundColor,
      foregroundColor: AppColors.textColor,
    ),

    //==========================================================================
    // Buttons
    //==========================================================================
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        backgroundColor: AppColors.buttonBackgroundColor,
        foregroundColor: AppColors.white,
        minimumSize: const Size(double.infinity, 52),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14.r)),
      ),
    ),

    //==========================================================================
    // Cards
    //==========================================================================
    cardTheme: CardThemeData(
      color: AppColors.cardColor,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
    ),

    //==========================================================================
    // Input Fields
    //==========================================================================
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.cardColor,
      contentPadding:  EdgeInsets.all(16.r),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14.r),
        borderSide:  BorderSide(
          color: AppColors.buttonBackgroundColor,
          width: 2.w,
        ),
      ),
    ),

    //==========================================================================
    // Divider
    //==========================================================================
    dividerColor: AppColors.borderColor,

    //==========================================================================
    // Progress Indicator
    //==========================================================================
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.buttonBackgroundColor,
    ),
  );
}
