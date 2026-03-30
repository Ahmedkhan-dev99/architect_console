import 'package:flutter/material.dart';

/// Global state provider for app-wide settings
class GlobalProvider extends ChangeNotifier {
  String _path = 'C:/xxx/xxxx/xxx';
  String _command = '';
  bool _isDarkMode = false;
  String _commandOutput = '';

  // Getters
  String get path => _path;
  String get command => _command;
  bool get isDarkMode => _isDarkMode;
  String get commandOutput => _commandOutput;

  // Setters
  void setPath(String newPath) {
    _path = newPath;
    notifyListeners();
  }

  void setCommand(String newCommand) {
    _command = newCommand;
    notifyListeners();
  }

  void setCommandOutput(String newCommandOutput) {
    _commandOutput = newCommandOutput;
    notifyListeners();
  }

  void setIsDarkMode(bool value) {
    _isDarkMode = value;
    notifyListeners();
  }
}
