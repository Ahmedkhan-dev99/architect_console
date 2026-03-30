import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/show_confirm_dialog.dart';
import 'package:architect_console/shared/widgets/u_button.dart';
import 'package:flutter/material.dart';

/// A card widget for displaying platform build options
class BuildPlatformCard extends StatelessWidget {
  const BuildPlatformCard({
    super.key,
    required this.icon,
    required this.title,
    required this.iconBgColor,
    required this.iconColor,
    required this.command,
  });

  final IconData icon;
  final String title;
  final Color iconBgColor;
  final Color iconColor;
  final String command;

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return UButton(
      ontap: () => showConfirmDialog(context, command),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: TextStyle(
              fontFamily: "ubuntu",
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: uColor.textColor,
            ),
          ),
        ],
      ),
    );
  }
}
