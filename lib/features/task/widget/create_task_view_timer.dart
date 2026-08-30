import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:progressive_time_picker/progressive_time_picker.dart';

import 'create_task_view_timer_summary.dart';
import 'create_task_view_timer_pickers.dart';
import 'create_task_view_timer_actions.dart';

typedef TaskTimerCallback = void Function(
  DateTime? startDate,
  DateTime? endDate,
  PickedTime startTime,
  PickedTime endTime,
);

class CreateTaskViewTimer extends ConsumerStatefulWidget {
  final TaskTimerCallback? onTimerChanged;
  const CreateTaskViewTimer({super.key, this.onTimerChanged});

  @override
  ConsumerState<CreateTaskViewTimer> createState() =>
      CreateTaskViewTimerState();
}

class CreateTaskViewTimerState extends ConsumerState<CreateTaskViewTimer> {
  final DateRangePickerController _datePickerController = DateRangePickerController();
  bool _isDatePickerVisible = false;

  DateTime? _startDate = DateTime.now();
  DateTime? _endDate = DateTime.now().add(const Duration(days: 1));

  PickedTime _startTime = PickedTime(h: 9, m: 0);
  PickedTime _endTime = PickedTime(h: 17, m: 0);

  @override
  void dispose() {
    _datePickerController.dispose();
    super.dispose();
  }

  DateTime? get startDate => _startDate;
  DateTime? get endDate => _endDate;
  PickedTime get startTime => _startTime;
  PickedTime get endTime => _endTime;

  void _notifyTimerChanged() {
    widget.onTimerChanged?.call(
      _startDate,
      _endDate,
      _startTime,
      _endTime,
    );
  }

  void _showDatePicker() {
    setState(() {
      _isDatePickerVisible = true;
    });
  }

  void _showTimePicker() {
    setState(() {
      _isDatePickerVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CreateTaskViewTimerSummary(
          startDate: _startDate,
          endDate: _endDate,
          startTime: _startTime,
          endTime: _endTime,
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CreateTaskViewTimerPickers(
              isDatePickerVisible: _isDatePickerVisible,
              startDate: _startDate,
              endDate: _endDate,
              startTime: _startTime,
              endTime: _endTime,
              datePickerController: _datePickerController,
              onDateRangeChanged: (start, end) {
                setState(() {
                  _startDate = start;
                  _endDate = end;
                });
                _notifyTimerChanged();
              },
              onTimeRangeChanged: (start, end) {
                setState(() {
                  _startTime = start;
                  _endTime = end;
                });
                _notifyTimerChanged();
              },
              onSelectToday: () {
                final now = DateTime.now();
                _datePickerController.selectedRange = PickerDateRange(now, now);
                setState(() {
                  _startDate = now;
                  _endDate = now;
                });
                _notifyTimerChanged();
              },
            ),
            CreateTaskViewTimerActions(
              onShowDatePicker: _showDatePicker,
              onShowTimePicker: _showTimePicker,
            ),
          ],
        ),
      ],
    );
  }
}
