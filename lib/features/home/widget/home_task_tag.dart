import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class TaskTag {
  final String text;
  final Color backgroundColor;
  final Color textColor;

  const TaskTag({
    required this.text,
    required this.backgroundColor,
    required this.textColor,
  });
}
