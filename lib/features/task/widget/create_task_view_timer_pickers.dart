import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class CreateTaskViewTimerPickers extends StatefulWidget {
  final bool isDatePickerVisible;
  final DateTime? startDate;
  final DateTime? endDate;
  final PickedTime startTime;
  final PickedTime endTime;
  final DateRangePickerController datePickerController;
  final Function(DateTime, DateTime?) onDateRangeChanged;
  final Function(PickedTime, PickedTime) onTimeRangeChanged;
  final VoidCallback onSelectToday;

  const CreateTaskViewTimerPickers({
    super.key,
    required this.isDatePickerVisible,
    required this.startDate,
    required this.endDate,
    required this.startTime,
    required this.endTime,
    required this.datePickerController,
    required this.onDateRangeChanged,
    required this.onTimeRangeChanged,
    required this.onSelectToday,
  });

  @override
  State<CreateTaskViewTimerPickers> createState() =>
      _CreateTaskViewTimerPickersState();
}

class _CreateTaskViewTimerPickersState extends State<CreateTaskViewTimerPickers>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipController;
  late Animation<double> _flipAnimation;
  bool _isFlipping = false;

  @override
  void initState() {
    super.initState();
    _flipController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );

    _flipAnimation = CurvedAnimation(
      parent: _flipController,
      curve: Curves.easeInOut,
    );

    // Set initial state based on widget property (0.0 = Date Picker, 1.0 = Time Picker)
    _flipController.value = widget.isDatePickerVisible ? 0.0 : 1.0;

    _flipController.addListener(() {
      if (mounted) setState(() {});
    });
  }

  @override
  void didUpdateWidget(CreateTaskViewTimerPickers oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isDatePickerVisible != oldWidget.isDatePickerVisible) {
      _flipToTarget(widget.isDatePickerVisible);
    }
  }

  @override
  void dispose() {
    _flipController.dispose();
    super.dispose();
  }

  void _flipToTarget(bool showDate) {
    if (_isFlipping) return;
    setState(() => _isFlipping = true);

    final target = showDate ? 0.0 : 1.0;
    _flipController.animateTo(target).then((_) {
      if (mounted) setState(() => _isFlipping = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDateVisible = _flipController.value < 0.5;

    return Expanded(
      child: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (_isFlipping) return;
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < -100) {
              // Swipe left to show time picker
              _flipToTarget(false);
            } else if (details.primaryVelocity! > 100) {
              // Swipe right to show date picker
              _flipToTarget(true);
            }
          }
        },
        onVerticalDragEnd: (details) {
          if (_isFlipping) return;
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < -100) {
              // Swipe left to show time picker
              _flipToTarget(false);
            } else if (details.primaryVelocity! > 100) {
              // Swipe right to show date picker
              _flipToTarget(true);
            }
          }
        },
        child: Container(
          child: Stack(
            children: [
              // Front Face (Date Picker)
              _buildDatePicker(isDateVisible),
              // Back Face (Time Picker)
              _buildTimePicker(!isDateVisible),
              // Flip overlay with 3D effect
              _buildFlipOverlay(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDatePicker(bool isVisible) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(_flipAnimation.value * 3.14159),
      child: Opacity(
        opacity: isVisible ? 1.0 : 0.0,
        child: Visibility(
          visible: isVisible,
          maintainState: true,
          child: _buildDatePickerContent(),
        ),
      ),
    );
  }

  Widget _buildTimePicker(bool isVisible) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateX(_flipAnimation.value * 3.14159 + 3.14159),
      child: Opacity(
        opacity: isVisible ? 1.0 : 0.0,
        child: Visibility(
          visible: isVisible,
          maintainState: true,
          child: _buildTimePickerContent(),
        ),
      ),
    );
  }

  Widget _buildDatePickerContent() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SfDateRangePicker(
            controller: widget.datePickerController,
            selectionMode: DateRangePickerSelectionMode.range,
            initialSelectedRange: PickerDateRange(
              widget.startDate,
              widget.endDate,
            ),
            backgroundColor: AppColors.surface,
            headerStyle: const DateRangePickerHeaderStyle(
              textStyle: AppTextStyle.titleMedium,
            ),
            monthCellStyle: const DateRangePickerMonthCellStyle(
              textStyle: AppTextStyle.bodyMedium,
            ),
            showTodayButton: false,
            showActionButtons: false,
            onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
              if (args.value is PickerDateRange) {
                widget.onDateRangeChanged(
                  args.value.startDate,
                  args.value.endDate ?? args.value.startDate,
                );
              }
            },
          ),
          TextButton(
            onPressed: widget.onSelectToday,
            child: Text(
              'Select Today',
              style: AppTextStyle.button.copyWith(color: AppColors.primary),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }

  Widget _buildTimePickerContent() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 24.h),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: TimePicker(
          initTime: widget.startTime,
          endTime: widget.endTime,
          height: 260.w,
          width: 260.w,
          primarySectors: 6,
          secondarySectors: 24,
          decoration: TimePickerDecoration(
            baseColor: AppColors.surfaceLight,
            sweepDecoration: TimePickerSweepDecoration(
              pickerStrokeWidth: 12,
              pickerColor: AppColors.primary,
              showConnector: true,
            ),
            initHandlerDecoration: TimePickerHandlerDecoration(
              color: AppColors.primaryLight,
              shape: BoxShape.circle,
              radius: 12,
              icon: const Icon(
                Icons.power_settings_new,
                size: 16,
                color: AppColors.backgroundDeep,
              ),
            ),
            endHandlerDecoration: TimePickerHandlerDecoration(
              color: AppColors.primaryDark,
              shape: BoxShape.circle,
              radius: 12,
              icon: const Icon(
                Icons.notifications_active_outlined,
                size: 16,
                color: AppColors.backgroundDeep,
              ),
            ),
            primarySectorsDecoration: TimePickerSectorDecoration(
              color: AppColors.textPrimary,
              width: 2,
              size: 6,
              radiusPadding: 24,
            ),
            secondarySectorsDecoration: TimePickerSectorDecoration(
              color: AppColors.textSecondary,
              width: 1,
              size: 4,
              radiusPadding: 24,
            ),
            clockNumberDecoration: TimePickerClockNumberDecoration(
              defaultTextColor: AppColors.textPrimary,
              defaultFontSize: 12,
              scaleFactor: 2.0,
              showNumberIndicators: true,
            ),
          ),
          onSelectionChange: (start, end, isDisableRange) {
            widget.onTimeRangeChanged(start, end);
          },
          onSelectionEnd: (start, end, isDisableRange) {
            // Handle end of selection if needed
          },
        ),
      ),
    );
  }

  Widget _buildFlipOverlay() {
    if (_flipAnimation.value > 0.05 && _flipAnimation.value < 0.95) {
      return IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Colors.transparent,
                Colors.white.withValues(alpha: 0.05 * _flipAnimation.value),
                Colors.transparent,
              ],
              stops: const [0.3, 0.5, 0.7],
            ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
