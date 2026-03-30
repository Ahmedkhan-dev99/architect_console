import 'package:architect_console/features/home/presentation/home_page.dart';
import 'package:architect_console/shared/util/app_color.dart';
import 'package:architect_console/shared/util/global_provider.dart';
import 'package:bitsdojo_window/bitsdojo_window.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// Global navigator key for accessing context from anywhere
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GlobalProvider(),
      child: const MyApp(),
    ),
  );

  // Window configuration
  doWhenWindowReady(() {
    final win = appWindow;
    const initialSize = Size(750, 700);
    win.minSize = initialSize;
    win.size = initialSize;
    win.alignment = Alignment.center;
    win.title = "Architect Console";
    win.show();
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    final isDarkMode = context.watch<GlobalProvider>().isDarkMode;

    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: uColor.bgColor,
        body: WindowBorder(
          color: uColor.borderColor,
          width: 1,
          child: Column(
            children: [
              // Custom Title Bar
              WindowTitleBarBox(
                child: Container(
                  color: uColor.bgColor,
                  child: Row(
                    children: [
                      const SizedBox(width: 12),
                      Icon(Icons.terminal, size: 14, color: uColor.accentColor),
                      const SizedBox(width: 8),
                      Text(
                        "ARCHITECT CONSOLE",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                          color: uColor.textColor,
                        ),
                      ),
                      Expanded(child: MoveWindow()),
                      IconButton(
                        onPressed: () {
                          context.read<GlobalProvider>().setIsDarkMode(
                            !isDarkMode,
                          );
                        },
                        icon: Icon(
                          isDarkMode ? Icons.sunny : Icons.nightlight,
                          color: uColor.textColor,
                        ),
                      ),
                      const WindowButtons(),
                    ],
                  ),
                ),
              ),
              // Main Content Area
              const Expanded(child: HomePage()),
            ],
          ),
        ),
      ),
    );
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({super.key});
  @override
  Widget build(BuildContext context) {
    final uColor = AppColor(context);
    final buttonColors = WindowButtonColors(
      iconNormal: uColor.textColor,
      mouseOver: uColor.textColor,
      iconMouseOver: uColor.bgColor,
    );

    return Row(
      children: [
        MinimizeWindowButton(colors: buttonColors),
        CloseWindowButton(colors: buttonColors),
      ],
    );
  }
}
