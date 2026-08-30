import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';

class TimelineCalendarSheet extends StatelessWidget {
  final DateTime selectedDate;
  final Function(DateTime) onDateSelected;

  const TimelineCalendarSheet({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  static Future<DateTime?> show(
    BuildContext context, {
    required DateTime initialDate,
    required Function(DateTime) onDateSelected,
  }) {
    return showModalBottomSheet<DateTime>(
      context: context,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => TimelineCalendarSheet(
        selectedDate: initialDate,
        onDateSelected: (date) {
          onDateSelected(date);
          Navigator.pop(context, date);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
        ),
      ),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 16.h),

          // Header
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Select Date',
                style: AppTextStyle.titleMedium.copyWith(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
              TextButton(
                onPressed: () => onDateSelected(DateTime.now()),
                style: TextButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  backgroundColor: AppColors.primary.withValues(alpha: 0.15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: Text(
                  'Today',
                  style: AppTextStyle.labelMedium.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16.h),

          // Syncfusion Calendar
          SizedBox(
            height: 320.h,
            child: SfDateRangePicker(
              selectionMode: DateRangePickerSelectionMode.single,
              initialSelectedDate: selectedDate,
              backgroundColor: Colors.transparent,
              todayHighlightColor: AppColors.primary,
              selectionColor: AppColors.primary,
              headerStyle: DateRangePickerHeaderStyle(
                backgroundColor: Colors.transparent,
                textAlign: TextAlign.center,
                textStyle: AppTextStyle.titleSmall.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              monthViewSettings: const DateRangePickerMonthViewSettings(
                viewHeaderStyle: DateRangePickerViewHeaderStyle(
                  textStyle: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              monthCellStyle: DateRangePickerMonthCellStyle(
                textStyle: const TextStyle(color: Colors.white, fontSize: 13),
                todayTextStyle: const TextStyle(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
                leadingDatesTextStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                trailingDatesTextStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                disabledDatesTextStyle: TextStyle(
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
              onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
                if (args.value is DateTime) {
                  onDateSelected(args.value as DateTime);
                }
              },
            ),
          ),
          SizedBox(height: 16.h),
        ],
      ),
    );
  }
}
