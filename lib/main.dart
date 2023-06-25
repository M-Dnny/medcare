import 'dart:async';

import 'package:flutter/material.dart';
import 'package:medcare/src/screens/splash/splash.dart';
import 'package:medcare/src/utils/constant/navigation_service.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
}
