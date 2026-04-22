import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_assets.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      brightness: Brightness.light,
      primaryColor: AppColors.lightPrimary,
      scaffoldBackgroundColor: AppColors.lightBackground,
      colorScheme: const ColorScheme.light(
        primary: AppColors.lightPrimary,
        surface: AppColors.lightBackground,
        onSurface: AppColors.lightText1,
      ),
      fontFamily: AppAssets.pretendard,
      useMaterial3: true,
      extensions: [CustomColors.light],
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      primaryColor: AppColors.darkPrimary,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.darkPrimary,
        surface: AppColors.darkBackground,
        onSurface: AppColors.darkText1,
      ),
      fontFamily: AppAssets.pretendard,
      useMaterial3: true,
      extensions: [CustomColors.dark],
    );
  }
}

// ThemeExtension for custom colors and assets that switch automatically
class CustomColors extends ThemeExtension<CustomColors> {
  final Color? bg;
  final Color? text1;
  final Color? text2;
  final Color? correct;
  final Color? error;
  final String? logo;
  final String? notificationIcon;

  const CustomColors({
    required this.bg,
    required this.text1,
    required this.text2,
    required this.correct,
    required this.error,
    required this.logo,
    required this.notificationIcon,
  });

  static const light = CustomColors(
    bg: AppColors.lightBackground,
    text1: AppColors.lightText1,
    text2: AppColors.lightText2,
    correct: AppColors.lightCorrect,
    error: AppColors.lightError,
    logo: AppAssets.lightLogo,
    notificationIcon: AppAssets.lightNotification,
  );

  static const dark = CustomColors(
    bg: AppColors.darkBackground,
    text1: AppColors.darkText1,
    text2: AppColors.darkText2,
    correct: AppColors.darkCorrect,
    error: AppColors.darkError,
    logo: AppAssets.darkLogo,
    notificationIcon: AppAssets.darkNotification,
  );

  @override
  CustomColors copyWith({
    Color? bg,
    Color? text1,
    Color? text2,
    Color? correct,
    Color? error,
    String? logo,
    String? notificationIcon,
  }) {
    return CustomColors(
      bg: bg ?? this.bg,
      text1: text1 ?? this.text1,
      text2: text2 ?? this.text2,
      correct: correct ?? this.correct,
      error: error ?? this.error,
      logo: logo ?? this.logo,
      notificationIcon: notificationIcon ?? this.notificationIcon,
    );
  }

  @override
  CustomColors lerp(ThemeExtension<CustomColors>? other, double t) {
    if (other is! CustomColors) return this;
    return CustomColors(
      bg: Color.lerp(bg, other.bg, t),
      text1: Color.lerp(text1, other.text1, t),
      text2: Color.lerp(text2, other.text2, t),
      correct: Color.lerp(correct, other.correct, t),
      error: Color.lerp(error, other.error, t),
      logo: t < 0.5 ? logo : other.logo,
      notificationIcon: t < 0.5 ? notificationIcon : other.notificationIcon,
    );
  }
}

// Helper to access custom colors easily
extension CustomColorsExtension on ThemeData {
  CustomColors get custom => extension<CustomColors>()!;
}
