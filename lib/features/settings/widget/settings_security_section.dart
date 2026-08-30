import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/settings/widget/settings_tile.dart';
import 'package:task_manager/generated/l10n.dart';

class SettingsSecuritySection extends StatelessWidget {
  const SettingsSecuritySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).accountAndSecurity,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 10.h),
        SettingsTile(
          icon: Icons.lock_outline_rounded,
          title: S.of(context).securityAndPin,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: AppColors.textMuted,
          ),
        ),
        SizedBox(height: 10.h),
        SettingsTile(
          icon: Icons.logout_rounded,
          title: S.of(context).logOut,
          iconColor: AppColors.danger,
          titleColor: AppColors.danger,
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: AppColors.danger,
          ),
          onTap: () {
            // handle logout
          },
        ),
      ],
    );
  }
}
