import 'dart:io';
import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Shows a success dialog after build completion
void showFinishDialog(BuildContext context, String folderPath, String command) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final uColor = AppColor(context);

      return Dialog(
        backgroundColor: Colors.transparent,
        child: Container(
          width: 320,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: context.read<GlobalProvider>().isDarkMode
                ? Colors.black
                : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: uColor.accentColor, width: 1.5),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Success Icon
              const Icon(
                Icons.check_circle_outline_rounded,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(height: 16),

              Text(
                'BUILD FINISHED!',
                style: TextStyle(
                  fontFamily: "ubuntu",
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                  color: uColor.textColor,
                  letterSpacing: 1.5,
                ),
              ),
              const SizedBox(height: 12),

              Text(
                'Your build has been completed successfully. You can find your file here:',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: "ubuntu",
                  fontSize: 12,
                  color: uColor.subTextColor,
                ),
              ),
              const SizedBox(height: 16),

              // Folder Path Link
              InkWell(
                onTap: () => _openBuildFolder(folderPath, command),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: uColor.accentColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.folder_open_rounded,
                        color: uColor.accentColor,
                        size: 20,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          '$folderPath\\build',
                          style: TextStyle(
                            color: uColor.accentColor,
                            fontSize: 11,
                            decoration: TextDecoration.underline,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Close Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: uColor.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'DONE',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: uColor.bgColor,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

/// Opens the build output folder in file explorer
void _openBuildFolder(String folderPath, String command) {
  Process.run('explorer.exe', [folderPath]);
}
