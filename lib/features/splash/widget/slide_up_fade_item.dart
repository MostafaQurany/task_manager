import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SlideUpFadeItem extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const SlideUpFadeItem({super.key, required this.child, required this.delay});

  @override
  State<SlideUpFadeItem> createState() => _SlideUpFadeItemState();
}

class _SlideUpFadeItemState extends State<SlideUpFadeItem> {
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    // Trigger the slide up change after the specified delay
    Future.delayed(widget.delay, () {
      if (mounted) {
        setState(() {
          _visible = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeOut,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeOutCubic,
        // Shifts the widget up 20 pixels when visible triggers
        transform: Matrix4.translationValues(0, _visible ? 0 : 20.h, 0),
        child: widget.child,
      ),
    );
  }
}
