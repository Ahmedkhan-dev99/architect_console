import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:architect_console/shared/util/growing_dot.dart';
import 'package:architect_console/shared/util/real_time_log_timestamp.dart';
import 'package:architect_console/shared/widgets/build_command_card.dart';
import 'package:architect_console/shared/widgets/build_platform_card.dart';
import 'package:architect_console/shared/widgets/build_section_title.dart';
import 'package:architect_console/shared/widgets/build_workspace_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Home page displaying workspace, commands, and platform build options
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Workspace Section
          const BuildWorkspaceBar(),
          const SizedBox(height: 22),

          // Useful Commands Section
          const BuildSectionTitle(
            icon: Icons.terminal_rounded,
            title: 'Useful Commands',
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 80,
            child: GridView.count(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              childAspectRatio: 4.5,
              children: const [
                BuildCommandCard(
                  icon: Icons.cleaning_services_rounded,
                  iconColor: Color(0xFFDC4D3D),
                  iconBgColor: Color(0xFF331C1A),
                  title: 'Clean Project',
                  subtitle: 'flutter clean',
                  command: "flutter clean",
                ),
                BuildCommandCard(
                  icon: Icons.auto_fix_high_rounded,
                  iconColor: Color(0xFF5CB9E3),
                  iconBgColor: Color(0xFF1A2A33),
                  title: 'Build Runner',
                  subtitle: 'flutter pub get',
                  command: "flutter pub get",
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Target Platforms Section
          const BuildSectionTitle(
            icon: Icons.layers_outlined,
            title: 'Target Platforms',
          ),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: 1.8,
              children: const [
                BuildPlatformCard(
                  icon: Icons.android,
                  iconColor: Color(0xFF3DDC84),
                  iconBgColor: Color(0xFF1A3320),
                  title: 'Android APK',
                  command: "flutter build apk --release",
                ),
                BuildPlatformCard(
                  icon: Icons.apple,
                  iconColor: Colors.white,
                  iconBgColor: Color(0xFF2A2A2A),
                  command: "flutter build ios",
                  title: 'iOS Archive',
                ),
                BuildPlatformCard(
                  icon: Icons.language,
                  iconColor: Color(0xFFFFA000),
                  iconBgColor: Color(0xFF332A1A),
                  command: "flutter build web",
                  title: 'Web App',
                ),
                BuildPlatformCard(
                  icon: Icons.desktop_windows,
                  iconColor: Color(0xFF5CB9E3),
                  iconBgColor: Color(0xFF1A2A33),
                  command: "flutter build windows",
                  title: 'Desktop',
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),

          // Live Stream Console
          _buildConsole(context),
          const SizedBox(height: 10),
          Center(
            child: Text(
              "Development By : Ahmed Khan",
              style: TextStyle(
                fontSize: 11,
                fontFamily: "ubuntu",
                fontWeight: FontWeight.w600,
                color: uColor.accentColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsole(BuildContext context) {
    final globalProvider = context.watch<GlobalProvider>();
    final uColor = AppColor(context);

    return Container(
      height: 180,
      decoration: BoxDecoration(
        color: uColor.bgColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: uColor.borderColor),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: uColor.bgColor,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              border: Border(
                bottom: BorderSide(color: uColor.borderColor, width: 1),
              ),
            ),
            child: Row(
              children: [
                const GrowingDot(),
                const Spacer(),
                const RealTimeLogTimestamp(),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (globalProvider.command.isNotEmpty)
                  _buildLogEntry(globalProvider.commandOutput, uColor),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLogEntry(String message, AppColor uColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: 'Command : ',
              style: TextStyle(
                fontFamily: "ubuntu",
                fontSize: 12,
                color: const Color.fromARGB(255, 249, 40, 37),
              ),
            ),
            TextSpan(
              text: message,
              style: TextStyle(
                fontFamily: "ubuntu",
                fontSize: 12,
                color: uColor.textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
