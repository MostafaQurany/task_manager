import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class TaskSummary extends StatefulWidget {
  const TaskSummary({super.key});

  @override
  State<TaskSummary> createState() => _TaskSummaryState();
}

class _TaskSummaryState extends State<TaskSummary>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInToLinear,
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  List<TextSpan> _buildSpans(List<_SpanData> spans, int maxChars) {
    final List<TextSpan> result = [];
    int remaining = maxChars;

    for (final spanData in spans) {
      if (remaining <= 0) break;
      final characters = spanData.text.characters;
      if (characters.length <= remaining) {
        result.add(TextSpan(text: spanData.text, style: spanData.style));
        remaining -= characters.length;
      } else {
        final visibleText = characters.take(remaining).toString();
        result.add(TextSpan(text: visibleText, style: spanData.style));
        remaining = 0;
      }
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    final defaultStyle = TextStyle(
      color: AppColors.textPrimary,
      fontSize: 28.sp,
    );
    final boldStyle = TextStyle(
      color: AppColors.textPrimary,
      fontSize: 28.sp,
      fontWeight: FontWeight.bold,
    );

    final spans = [
      _SpanData('You have got ', defaultStyle),
      _SpanData('4 Tasks \n', boldStyle),
      _SpanData('today ', boldStyle),
      _SpanData('to complete👋', defaultStyle),
    ];

    final totalChars = spans.fold<int>(
      0,
      (sum, span) => sum + span.text.characters.length,
    );

    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        final int visibleCharCount = (_animation.value * totalChars).round();

        return RichText(
          textAlign: TextAlign.start,
          text: TextSpan(children: _buildSpans(spans, visibleCharCount)),
        );
      },
    );
  }
}

class _SpanData {
  final String text;
  final TextStyle style;

  const _SpanData(this.text, this.style);
}
