import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:observed/core/theme/app_text_styles.dart';
import 'package:observed/core/theme/app_theme.dart';

class ChattingScreen extends StatelessWidget {
  const ChattingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).custom;

    return Scaffold(
      backgroundColor: customColors.bg,
      appBar: AppBar(
        backgroundColor: customColors.bg,
        elevation: 0,
        title: Text(
          "Chatting",
          style: AppTextStyles.h3.copyWith(color: customColors.text1),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 10.h,
          bottom: 100.h,
        ), // Extra padding for bottom bar
        itemCount: 20,
        itemBuilder: (context, index) {
          bool isMe = index % 2 == 0;
          return Align(
            alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: EdgeInsets.only(bottom: 12.h),
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: isMe
                    ? customColors.text1
                    : customColors.text2!.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                isMe
                    ? "Check out this glass effect! ✨"
                    : "Wow, it looks amazing behind the bar!",
                style: AppTextStyles.m4.copyWith(
                  color: isMe ? customColors.bg : customColors.text1,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
