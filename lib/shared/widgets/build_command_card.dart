import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/show_confirm_dialog.dart';
import 'package:architect_console/shared/widgets/u_button.dart';
import 'package:flutter/material.dart';

/// A card widget for displaying command options
class BuildCommandCard extends StatelessWidget {
  const BuildCommandCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconBgColor,
    required this.iconColor,
    required this.command,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconBgColor;
  final Color iconColor;
  final String command;

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return UButton(
      ontap: () => showConfirmDialog(context, command),
      child: Row(
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
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: "ubuntu",
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: uColor.textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontFamily: "ubuntu",
                    fontSize: 12,
                    color: uColor.subTextColor,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
    );
  }
}
