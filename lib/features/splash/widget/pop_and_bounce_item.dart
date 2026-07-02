import 'package:flutter/material.dart';

class PopAndBounceItem extends StatefulWidget {
  final Widget child;
  final Duration delay;

  const PopAndBounceItem({super.key, required this.child, required this.delay});

  @override
  State<PopAndBounceItem> createState() => _PopAndBounceItemState();
}

class _PopAndBounceItemState extends State<PopAndBounceItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAndBounceAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 1200,
      ), // Gives time for the bounce to settle
    );

    // ElasticOut naturally overshoots 1.0 (gets big) and shakes back down
    _scaleAndBounceAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );

    // Wait for its staggered turn in the splash sequence
    Future.delayed(widget.delay, () {
      if (mounted) {
        _controller.forward();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scaleAndBounceAnimation,
      child: FadeTransition(
        // Fade in quickly using the same controller timeline
        opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
        child: widget.child,
      ),
    );
  }
}
