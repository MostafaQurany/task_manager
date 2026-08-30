import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/generated/l10n.dart';

class SettingsHeader extends StatelessWidget {
  const SettingsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      S.of(context).profileAndSettings,
      style: AppTextStyle.headlineMedium.copyWith(
        color: Colors.white,
        fontSize: 22.sp,
      ),
    );
  }
}
