import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/core/constants/app_images.dart';
import 'package:task_manager/core/routes/routes_name.dart';
import 'package:task_manager/core/theme/app_colors.dart';
import 'package:task_manager/features/splash/widget/center_logo_animation.dart';
import '../../../core/widgets/background_gradiant.dart';
import '../widget/pop_and_bounce_item.dart';
import '../widget/slide_up_fade_item.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView>
    with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundGradient(
        activeAnimation: true,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CenterLogoAnimation(),
            const SizedBox(height: 16),

            // 1. First text block slides up after 200ms
            SlideUpFadeItem(
              delay: const Duration(milliseconds: 200),
              child: RichText(
                text: TextSpan(
                  text: 'Create ',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Task And',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 2. Second text block slides up after 500ms
            SlideUpFadeItem(
              delay: const Duration(milliseconds: 500),
              child: RichText(
                text: TextSpan(
                  text: 'Keep Being ',
                  style: TextStyle(color: Colors.white, fontSize: 18.sp),
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Updated',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),

            // 3. Subtitle description text slides up after 800ms
            SlideUpFadeItem(
              delay: const Duration(milliseconds: 800),
              child: Text(
                "Task manager allows you to\nmake tasks and keep them in\ncheck and mamage",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: AppColors.textMuted,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
            SizedBox(height: 40.h),

            // 4. Dot indicator dots fade in after 1100ms
            SlideUpFadeItem(
              delay: const Duration(milliseconds: 1100),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                spacing: 5.w,
                children: [
                  Container(
                    width: 5.w,
                    height: 5.h,
                    decoration: const BoxDecoration(
                      color: AppColors.textMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 5.w,
                    height: 5.h,
                    decoration: const BoxDecoration(
                      color: AppColors.textMuted,
                      shape: BoxShape.circle,
                    ),
                  ),
                  Container(
                    width: 5.w,
                    height: 10.h,
                    decoration: BoxDecoration(
                      color: AppColors.whiteCard,
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(10.sp),
                        top: Radius.circular(10.sp),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),

            // 5. Replace SlideUpFadeItem with the bouncing pop effect
            PopAndBounceItem(
              delay: const Duration(milliseconds: 800),
              child: SizedBox(
                width: 170
                    .w, // Assigned an explicit width so it has clean visual scale symmetry
                child: ElevatedButton(
                  onPressed: () {
                    context.go(RoutesName.homeScreen);
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("Start Now", style: TextStyle(fontSize: 18.sp)),
                      Icon(Icons.arrow_forward, size: 28.sp),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
