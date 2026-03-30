import 'package:architect_console/shared/util/app_color.dart';
import 'package:flutter/material.dart';

/// Custom elevated button with consistent styling
class UButton extends StatelessWidget {
  const UButton({super.key, required this.child, required this.ontap});

  final Widget child;
  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return ElevatedButton(
      onPressed: ontap,
      style: ElevatedButton.styleFrom(
        backgroundColor: uColor.bgColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: uColor.borderColor),
        ),
        elevation: 2,
      ),
      child: child,
    );
  }
}
