import 'package:architect_console/shared/util/app_color.dart';
import 'package:flutter/material.dart';

/// A section title widget with icon
class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({super.key, required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return Row(
      children: [
        Icon(icon, color: uColor.subTextColor, size: 18),
        const SizedBox(width: 10),
        Text(
          title.toUpperCase(),
          style: TextStyle(
            fontFamily: "ubuntu",
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: uColor.subTextColor,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}
