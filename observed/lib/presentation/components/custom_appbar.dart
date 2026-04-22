import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:observed/core/theme/app_theme.dart';
import 'package:observed/core/theme/app_text_styles.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).custom;

    return AppBar(
      centerTitle: false,
      backgroundColor: customColors.bg,
      elevation: 0,
      title: Text(
        "Observed",
        style: AppTextStyles.h3.copyWith(color: customColors.text1),
      ),
      actions: [
        SvgPicture.asset(
          customColors.notificationIcon!,
          width: 28.w,
          height: 28.h,
        ),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Container(
            width: 36.w,
            height: 36.h,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Icon(Icons.error_outline, color: Colors.white),
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
