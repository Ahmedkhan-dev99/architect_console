import 'package:architect_console/features/run_command.dart';
import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shows a confirmation dialog before executing a build command
void showConfirmDialog(BuildContext context, String command) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      final uColor = AppColor(context);

      return Dialog(
        child: Container(
          width: 300,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.watch<GlobalProvider>().isDarkMode
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: uColor.borderColor, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon & Title
              Row(
                children: [
                  Icon(
                    Icons.help_outline_rounded,
                    color: uColor.accentColor,
                    size: 22,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    'CONFIRM ACTION',
                    style: TextStyle(
                      fontFamily: "ubuntu",
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: uColor.textColor,
                      letterSpacing: 1.2,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Message
              Text(
                'Are you sure you want to proceed with this build? This might take a few minutes.',
                style: TextStyle(
                  fontFamily: "ubuntu",
                  fontSize: 13,
                  color: uColor.subTextColor,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // Cancel Button
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    style: TextButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                    ),
                    child: Text(
                      'CANCEL',
                      style: TextStyle(
                        fontFamily: "ubuntu",
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: uColor.textColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),

                  // Confirm Button
                  ElevatedButton(
                    onPressed: () {
                      context.read<GlobalProvider>().setCommand(command);
                      runCommand(command, context);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: uColor.accentColor,
                      foregroundColor: uColor.bgColor,
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'YES, PROCEED',
                      style: TextStyle(
                        fontFamily: "ubuntu",
                        fontSize: 12,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
