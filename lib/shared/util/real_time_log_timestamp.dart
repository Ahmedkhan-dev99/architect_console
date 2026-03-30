import 'dart:async';
import 'package:architect_console/shared/util/app_color.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

/// Real-time clock widget showing current timestamp
class RealTimeLogTimestamp extends StatefulWidget {
  const RealTimeLogTimestamp({super.key});

  @override
  State<RealTimeLogTimestamp> createState() => _RealTimeLogTimestampState();
}

class _RealTimeLogTimestampState extends State<RealTimeLogTimestamp> {
  late Timer _timer;
  String _currentTime = '';

  @override
  void initState() {
    super.initState();
    _updateTime();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      _updateTime();
    });
  }

  void _updateTime() {
    if (mounted) {
      setState(() {
        _currentTime = DateFormat('hh:mm:ss a').format(DateTime.now());
      });
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    return Text(
      ' $_currentTime  ',
      style: TextStyle(
        fontFamily: "ubuntu",
        fontSize: 11,
        fontWeight: FontWeight.w600,
        color: uColor.accentColor,
      ),
    );
  }
}
