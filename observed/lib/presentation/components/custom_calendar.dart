import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:observed/core/theme/app_theme.dart';
import 'package:observed/core/theme/app_text_styles.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  DateTime _selectedDate = DateTime.now();
  late DateTime _focusedDate;

  @override
  void initState() {
    super.initState();
    _focusedDate = _selectedDate;
  }

  // Get days of the week starting from a specific date (e.g., current week)
  List<DateTime> _getWeekDays(DateTime date) {
    // Find the Monday of the current week
    int dayOffset = date.weekday - 1;
    DateTime monday = date.subtract(Duration(days: dayOffset));
    return List.generate(7, (index) => monday.add(Duration(days: index)));
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).custom;
    final weekDays = _getWeekDays(_focusedDate);

    return Column(
      children: [
        // Header: < Month, Day(weekday) >
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  _focusedDate = _focusedDate.subtract(const Duration(days: 7));
                });
              },
              icon: Icon(
                Icons.chevron_left,
                color: customColors.text1,
                size: 24.sp,
              ),
            ),
            Text(
              DateFormat('MMM, d(E)').format(_focusedDate),
              style: AppTextStyles.m4.copyWith(color: customColors.text1),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  _focusedDate = _focusedDate.add(const Duration(days: 7));
                });
              },
              icon: Icon(
                Icons.chevron_right,
                color: customColors.text1,
                size: 24.sp,
              ),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        // Day Labels & Dates
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: weekDays.map((date) {
            bool isSelected = DateUtils.isSameDay(date, _selectedDate);
            String dayName = DateFormat('E').format(date).toLowerCase();

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                  _focusedDate = date;
                });
              },
              child: Column(
                children: [
                  Text(
                    dayName,
                    style: AppTextStyles.m4.copyWith(
                      color: isSelected
                          ? customColors.text1
                          : customColors.text2,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    date.day.toString(),
                    style: AppTextStyles.m2.copyWith(
                      color: isSelected
                          ? customColors.text1
                          : customColors.text2,
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),

        SizedBox(height: 20.h),
        Container(
          width: 24.w,
          height: 2.h,
          decoration: BoxDecoration(
            color: customColors.text2,
            borderRadius: BorderRadius.circular(2.r),
          ),
        ),
      ],
    );
  }
}
