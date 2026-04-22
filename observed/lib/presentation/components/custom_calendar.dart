import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:intl/intl.dart';
import 'package:observed/core/theme/app_theme.dart';
import 'package:observed/core/theme/app_text_styles.dart';

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  @override
  Widget build(BuildContext context) {
    final customColors = Theme.of(context).custom;

    return Column(
      children: [
        // Using AnimatedSize to fit the content height perfectly
        AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2030, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: _calendarFormat,
            rowHeight: 45.h, // Compact row height
            daysOfWeekHeight: 30.h, // Compact day of week height
            availableCalendarFormats: const {
              CalendarFormat.month: 'Month',
              CalendarFormat.week: 'Week',
            },
            locale: 'en_US',
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },

            // Header Style
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              titleTextStyle: AppTextStyles.m4.copyWith(
                color: customColors.text1,
              ),
              leftChevronIcon: Icon(
                Icons.chevron_left,
                color: customColors.text1,
                size: 24.sp,
              ),
              rightChevronIcon: Icon(
                Icons.chevron_right,
                color: customColors.text1,
                size: 24.sp,
              ),
              headerPadding: EdgeInsets.only(bottom: 10.h),
              titleTextFormatter: (date, locale) =>
                  DateFormat('MMM, d(E)').format(date),
            ),

            // Days of week style
            daysOfWeekStyle: DaysOfWeekStyle(
              weekdayStyle: AppTextStyles.m4.copyWith(
                color: customColors.text2,
              ),
              weekendStyle: AppTextStyles.m4.copyWith(
                color: customColors.text2,
              ),
              dowTextFormatter: (date, locale) =>
                  DateFormat('E').format(date).toLowerCase(),
            ),

            // Calendar Builders
            calendarBuilders: CalendarBuilders(
              defaultBuilder: (context, day, focusedDay) {
                return _buildDayCell(day, customColors.text2!, false);
              },
              selectedBuilder: (context, day, focusedDay) {
                return _buildDayCell(day, customColors.text1!, true);
              },
              todayBuilder: (context, day, focusedDay) {
                return _buildDayCell(day, customColors.text2!, false);
              },
              outsideBuilder: (context, day, focusedDay) {
                return _buildDayCell(
                  day,
                  customColors.text2!.withOpacity(0.3),
                  false,
                );
              },
            ),
          ),
        ),

        // Handle
        GestureDetector(
          onVerticalDragEnd: (details) {
            final velocity = details.primaryVelocity ?? 0;
            if (velocity > 0) {
              setState(() => _calendarFormat = CalendarFormat.month);
            } else if (velocity < 0) {
              setState(() => _calendarFormat = CalendarFormat.week);
            }
          },
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 15.h), // Consistent padding
            color: Colors.transparent,
            width: double.infinity,
            alignment: Alignment.center,
            child: Container(
              width: 24.w,
              height: 2.h,
              decoration: BoxDecoration(
                color: customColors.text2,
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDayCell(DateTime day, Color textColor, bool isSelected) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          day.day.toString(),
          style: AppTextStyles.m4.copyWith(
            color: isSelected ? Theme.of(context).custom.text1 : textColor,
          ),
        ),
      ],
    );
  }
}
