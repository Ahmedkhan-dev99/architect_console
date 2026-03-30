import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:architect_console/shared/util/select_folder.dart';
import 'package:architect_console/shared/widgets/u_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Workspace bar widget for displaying and selecting project path
class BuildWorkspaceBar extends StatelessWidget {
  const BuildWorkspaceBar({super.key});

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    final globalProvider = context.watch<GlobalProvider>();
    final isDark = globalProvider.isDarkMode;

    return UButton(
      ontap: () {},
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Text(
              'WORKSPACE',
              style: TextStyle(
                fontFamily: "ubuntu",
                fontSize: 14,
                fontWeight: FontWeight.w700,
                color: uColor.accentColor,
                letterSpacing: 1.2,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Container(
                clipBehavior: Clip.antiAliasWithSaveLayer,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: uColor.bgColor,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: uColor.borderColor),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.folder_open_rounded,
                      color: Colors.grey[600],
                      size: 16,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: SelectableText(
                        globalProvider.path,
                        maxLines: 1,
                        style: TextStyle(
                          fontFamily: "ubuntu",
                          fontSize: 13,
                          color: uColor.textColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            _BrowseButton(isDark: isDark),
          ],
        ),
      ),
    );
  }
}

class _BrowseButton extends StatelessWidget {
  const _BrowseButton({required this.isDark});

  final bool isDark;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => selectDirectory(context),
      style:
          ElevatedButton.styleFrom(
            backgroundColor: isDark ? Colors.black : Colors.white,
            foregroundColor: isDark ? Colors.white : Colors.black,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: isDark ? Colors.white : Colors.black),
            ),
            elevation: 0,
          ).copyWith(
            overlayColor: WidgetStateProperty.all(
              Colors.white.withValues(alpha: 0.05),
            ),
          ),
      child: const Text(
        'Browse',
        style: TextStyle(
          fontFamily: "ubuntu",
          fontSize: 13,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
