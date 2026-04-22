import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:observed/core/theme/app_theme.dart';

class MainScreen extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const MainScreen({super.key, required this.navigationShell});

  void _onTap(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).custom;

    return Scaffold(
      extendBody: true,
      body: navigationShell,
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(100.r),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
              child: Container(
                height: 70.h,
                decoration: BoxDecoration(
                  // Added gradient for better visibility and premium glass feel
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      customColors.bg!.withValues(alpha: 0.9),
                      customColors.bg!.withValues(alpha: 0.6),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(100.r),
                  border: Border.all(
                    color: Colors.white.withValues(alpha: 0.3),
                    width: 1.5,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildNavItem(0, Icons.home_rounded, Icons.home_outlined),
                    _buildNavItem(
                      1,
                      Icons.chat_bubble_rounded,
                      Icons.chat_bubble_outline_rounded,
                    ),
                    _buildNavItem(
                      2,
                      Icons.search_rounded,
                      Icons.search_rounded,
                    ),
                    _buildNavItem(
                      3,
                      Icons.insert_chart_rounded,
                      Icons.insert_chart_outlined_rounded,
                    ),
                    _buildNavItem(
                      4,
                      Icons.person_rounded,
                      Icons.person_outline_rounded,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData activeIcon, IconData inactiveIcon) {
    final isSelected = navigationShell.currentIndex == index;
    return Builder(
      builder: (context) {
        final customColors = Theme.of(context).custom;
        return GestureDetector(
          onTap: () => _onTap(index),
          behavior: HitTestBehavior.opaque,
          child: SizedBox(
            width: 50.w,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isSelected ? activeIcon : inactiveIcon,
                  color: isSelected ? customColors.text1 : customColors.text1!.withValues(alpha: 0.4),
                  size: 28.sp,
                ),
                if (isSelected) ...[
                  SizedBox(height: 4.h),
                  Container(
                    width: 4.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: customColors.text1,
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ],
            ),
          ),
        );
      },
    );
  }
}
