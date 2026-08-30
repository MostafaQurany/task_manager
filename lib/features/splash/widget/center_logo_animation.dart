import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:math' as math;
import '../../../core/constants/app_images.dart';

class CenterLogoAnimation extends StatefulWidget {
  const CenterLogoAnimation({super.key});

  @override
  State<CenterLogoAnimation> createState() => _CenterLogoAnimationState();
}

class _CenterLogoAnimationState extends State<CenterLogoAnimation>
    with TickerProviderStateMixin {
  late AnimationController animationController;
  late AnimationController scaleController;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 15),
    );
    animationController.repeat();

    scaleController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 600),
    );
    scaleController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: animationController,
            builder: (context, child) {
              return Transform.rotate(
                angle: animationController.value * (2 * math.pi),
                child: Image.asset(AppImages.circle, width: 250.w, height: 250.h),
              );
            },
          ),
        ),
        AnimatedBuilder(
          animation: scaleController,
          builder: (context, child) {
            return Transform.scale(
              scale: scaleController.value,
              child: Center(
                child: Image.asset(
                  AppImages.tLogo,
                  width: 100.w,
                  height: 100.h,
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
