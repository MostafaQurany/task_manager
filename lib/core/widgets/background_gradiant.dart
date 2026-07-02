import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_manager/core/theme/app_colors.dart';

class BackgroundGradient extends StatefulWidget {
  final bool activeAnimation;
  final Widget child;
  const BackgroundGradient({
    super.key,
    required this.activeAnimation,
    required this.child,
  });

  @override
  State<BackgroundGradient> createState() => _BackgroundGradientState();
}

class _BackgroundGradientState extends State<BackgroundGradient>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _curveAnimation;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _curveAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOutExpo,
    );

      if (widget.activeAnimation) {
        _controller.forward();
      }
  
  }

  @override
  void didUpdateWidget(covariant BackgroundGradient oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.activeAnimation != oldWidget.activeAnimation) {
      if (widget.activeAnimation) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _curveAnimation,
      builder: (context, child) {
        final currentStop = _curveAnimation.value * 0.32;

        return Container(
          decoration: BoxDecoration(
            gradient: !widget.activeAnimation
                ? AppColors.mainGradient
                : LinearGradient(
                    // Aligns the start above the screen (-1.2) to simulate negative stops safely
                    begin: const Alignment(0.0, -1.2),
                    end: Alignment.bottomLeft,
                    colors: const [
                      AppColors.primary,
                      Color(0xFF14161E),
                      Color(0xFF08090D),
                      Color(0xFF000000),
                      Color.fromARGB(255, 48, 51, 58),
                    ],
                    // Corrected safe order: 0.0, then currentStop (0.0 up to 0.28)
                    stops: [0.0, currentStop, 0.52, 0.95, 1.0],
                  ),
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
