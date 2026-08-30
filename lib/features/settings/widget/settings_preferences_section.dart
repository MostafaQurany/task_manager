import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/localization/locale_provider.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/core/theme/app_text_style.dart';
import 'package:task_manager/features/settings/widget/settings_tile.dart';
import 'package:task_manager/generated/l10n.dart';

class SettingsPreferencesSection extends ConsumerStatefulWidget {
  const SettingsPreferencesSection({super.key});

  @override
  ConsumerState<SettingsPreferencesSection> createState() =>
      _SettingsPreferencesSectionState();
}

class _SettingsPreferencesSectionState
    extends ConsumerState<SettingsPreferencesSection> {
  bool _notificationsEnabled = true;

  void _showLanguageDialog(BuildContext context) {
    final currentLocale = ref.read(localeProvider);

    showModalBottomSheet(
      context: context,
      useRootNavigator: true,
      backgroundColor: AppColors.surfaceCard,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16.h),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    margin: EdgeInsets.only(bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.2),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ),
                Text(
                  S.of(context).selectLanguage,
                  style: AppTextStyle.titleMedium.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 16.h),
                _buildLanguageOption(
                  ctx: ctx,
                  title: 'English (US)',
                  locale: const Locale('en'),
                  isSelected: currentLocale.languageCode == 'en',
                ),
                SizedBox(height: 10.h),
                _buildLanguageOption(
                  ctx: ctx,
                  title: 'العربية (Arabic)',
                  locale: const Locale('ar'),
                  isSelected: currentLocale.languageCode == 'ar',
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildLanguageOption({
    required BuildContext ctx,
    required String title,
    required Locale locale,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        ref.read(localeProvider.notifier).setLocale(locale);
        Navigator.pop(ctx);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primary.withValues(alpha: 0.15)
              : AppColors.surfaceSoft,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: isSelected
                ? AppColors.primary
                : Colors.white.withValues(alpha: 0.08),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppTextStyle.titleSmall.copyWith(
                color: isSelected ? AppColors.primary : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.primary,
                size: 20.sp,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentLocale = ref.watch(localeProvider);
    final languageSubtitle = currentLocale.languageCode == 'ar'
        ? S.of(context).arabic
        : S.of(context).english;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          S.of(context).preferences,
          style: AppTextStyle.bodySmall.copyWith(
            color: AppColors.textSecondary,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
        SizedBox(height: 10.h),
        SettingsTile(
          icon: Icons.notifications_active_outlined,
          title: S.of(context).pushNotifications,
          trailing: Switch(
            value: _notificationsEnabled,
            activeThumbColor: AppColors.primary,
            onChanged: (val) {
              setState(() => _notificationsEnabled = val);
            },
          ),
        ),
        SizedBox(height: 10.h),
        SettingsTile(
          icon: Icons.language_rounded,
          title: S.of(context).language,
          subtitle: languageSubtitle,
          onTap: () => _showLanguageDialog(context),
          trailing: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14.sp,
            color: AppColors.textMuted,
          ),
        ),
      ],
    );
  }
}
