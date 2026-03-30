import 'package:architect_console/shared/util/app_color.dart';
import 'package:flutter/material.dart';

/// Animated pulsing dot indicator for live stream status
class GrowingDot extends StatefulWidget {
  const GrowingDot({super.key});

  @override
  State<GrowingDot> createState() => _GrowingDotState();
}

class _GrowingDotState extends State<GrowingDot>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _animation = Tween<double>(
      begin: 1.0,
      end: 1.8,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);

    return Row(
      children: [
        SizedBox(
          width: 20,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                width: 8 * _animation.value,
                height: 8 * _animation.value,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: uColor.accentColor.withValues(alpha: 0.3),
                ),
                child: Center(
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: uColor.accentColor,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Text(
          'LIVE STREAM',
          style: TextStyle(
            fontFamily: "ubuntu",
            fontSize: 11,
            fontWeight: FontWeight.bold,
            color: uColor.accentColor,
          ),
        ),
      ],
    );
  }
}
