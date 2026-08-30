import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/settings/widget/settings_header.dart';
import 'package:task_manager/features/settings/widget/settings_preferences_section.dart';
import 'package:task_manager/features/settings/widget/settings_profile_card.dart';
import 'package:task_manager/features/settings/widget/settings_security_section.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(gradient: AppColors.softPeachGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
          child: CustomScrollView(
            slivers: [
              const SliverToBoxAdapter(child: SettingsHeader()),
              SliverToBoxAdapter(child: SizedBox(height: 18.h)),
              const SliverToBoxAdapter(child: SettingsProfileCard()),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              const SliverToBoxAdapter(child: SettingsPreferencesSection()),
              SliverToBoxAdapter(child: SizedBox(height: 20.h)),
              const SliverToBoxAdapter(child: SettingsSecuritySection()),
              SliverToBoxAdapter(child: SizedBox(height: 100.h)),
            ],
          ),
        ),
      ),
    );
  }
}
