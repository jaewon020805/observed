import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:observed/core/router/app_routes.dart';
import 'package:observed/core/theme/app_theme.dart';
import 'package:observed/core/theme/app_text_styles.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go(AppRoutes.home);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Access theme-aware custom colors
    final customColors = Theme.of(context).custom;

    return Scaffold(
      backgroundColor: customColors.bg,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(customColors.logo!, width: 102.w, height: 46.h),
            SizedBox(height: 30.h),
            Text(
              "Observed",
              style: AppTextStyles.h2.copyWith(color: customColors.text1),
            ),
          ],
        ),
      ),
    );
  }
}
