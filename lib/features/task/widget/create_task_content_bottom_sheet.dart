import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_style.dart';

class CreateTaskContentBottomSheet extends StatefulWidget {
  final String initialContent;
  const CreateTaskContentBottomSheet({
    super.key,
    required this.initialContent,
  });

  static Future<String?> show(BuildContext context, String initialContent) {
    return showModalBottomSheet<String>(
      context: context,
      useRootNavigator: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateTaskContentBottomSheet(
        initialContent: initialContent,
      ),
    );
  }

  @override
  State<CreateTaskContentBottomSheet> createState() =>
      _CreateTaskContentBottomSheetState();
}

class _CreateTaskContentBottomSheetState
    extends State<CreateTaskContentBottomSheet> {
  late TextEditingController _controller;
  int _charCount = 0;
  final int _maxChars = 500;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialContent);
    _charCount = widget.initialContent.length;
    _controller.addListener(() {
      setState(() {
        _charCount = _controller.text.length;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(bottom: 12.h),
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: AppColors.border,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Task Content',
                  style: AppTextStyle.titleLarge,
                ),
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close, color: AppColors.textSecondary),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              'What needs to be done?',
              style: AppTextStyle.bodyMedium.copyWith(color: AppColors.textSecondary),
            ),
            SizedBox(height: 12.h),
            Container(
              decoration: BoxDecoration(
                color: AppColors.surfaceSoft,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                    color: AppColors.borderLight.withValues(alpha: 0.1)),
              ),
              child: TextField(
                controller: _controller,
                maxLines: 6,
                maxLength: _maxChars,
                style: AppTextStyle.bodyLarge.copyWith(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  hintText: 'e.g. Prepare the weekly sales report...',
                  hintStyle: AppTextStyle.bodyMedium.copyWith(color: AppColors.textMuted),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.all(16.w),
                  counterText: '',
                ),
              ),
            ),
            SizedBox(height: 8.h),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '$_charCount / $_maxChars',
                style: AppTextStyle.bodySmall.copyWith(color: AppColors.textMuted),
              ),
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop(_controller.text);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: AppColors.backgroundDeep,
                padding: EdgeInsets.symmetric(vertical: 14.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Save Content',
                style: AppTextStyle.button.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }
}
