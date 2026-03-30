import 'package:architect_console/shared/util/global_provider.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Opens a folder selection dialog and updates the global provider
Future<void> selectDirectory(BuildContext context) async {
  final selectedDirectory = await FilePicker.platform.getDirectoryPath();

  if (selectedDirectory != null) {
    if (context.mounted) {
      context.read<GlobalProvider>().setPath(selectedDirectory);
    }
  }
}
