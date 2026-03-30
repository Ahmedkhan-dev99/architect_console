import 'dart:convert';
import 'dart:io';

import 'package:architect_console/main.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:architect_console/shared/util/show_finish_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Executes a shell command and streams the output
Future<void> runCommand(String command, BuildContext context) async {
  final provider = context.read<GlobalProvider>();
  final workingDir = provider.path;

  try {
    provider.setCommandOutput("Running: $command...\n\n");

    final process = await Process.start(
      'powershell.exe',
      ['-Command', command],
      workingDirectory: workingDir,
      runInShell: true,
    );

    final outputBuffer = StringBuffer();

    // Listen to stdout
    process.stdout.transform(utf8.decoder).listen((data) {
      outputBuffer.write(data);
      provider.setCommandOutput(provider.commandOutput + data);
    });

    // Listen to stderr
    process.stderr.transform(utf8.decoder).listen((data) {
      provider.setCommandOutput("${provider.commandOutput}\n[ERROR]: $data");
    });

    // Wait for process to complete
    final exitCode = await process.exitCode;

    provider.setCommandOutput(
      "${provider.commandOutput}\n\n--- Process Finished (Code: $exitCode) ---",
    );

    // Show success dialog for build commands
    if (exitCode == 0) {
      final navContext = navigatorKey.currentContext;

      if (navContext != null && navContext.mounted) {
        if (command != "flutter clean" && command != "flutter pub get") {
          showFinishDialog(navContext, workingDir, command);
        }
      }
    }
  } catch (e) {
    provider.setCommandOutput("Failed to start process: $e");
  }
}
