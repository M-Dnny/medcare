import 'package:flutter/material.dart';
import 'package:medcare/src/utils/constant/navigation_service.dart';
import 'package:medcare/src/utils/routes/router.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/theme/typography.dart';
import 'package:medcare/src/utils/widgets/bottom_bar.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          navigatorKey: NavigationService.navigatorKey,
          restorationScopeId: 'app',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            useMaterial3: true,
            colorScheme: lightColorScheme,
            textTheme: textTheme,
          ),
          darkTheme: ThemeData(
            useMaterial3: true,
            colorScheme: darkColorScheme,
            textTheme: textTheme,
          ),
          themeMode: settingsController.themeMode,
          onGenerateRoute: (setting) =>
              generateRoute(setting, settingsController),
        );
      },
    );
  }
}
