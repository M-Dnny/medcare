import 'package:flutter/material.dart';
import 'package:medcare/src/utils/constant/keys.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'src/app.dart';
import 'src/settings/settings_controller.dart';
import 'src/settings/settings_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/* Provider */
// final nameProvider = Provider((ref) => "Danish Mansoori");

/* StateProvider */
// final nameProvider = StateProvider<String?>((ref) => null);

/* StateNotifierProvider */
// final userProvider =
//     StateNotifierProvider<UserNotifier, User>((ref) => UserNotifier());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(url: url, anonKey: anonKey);
  final settingsController = SettingsController(SettingsService());

  await settingsController.loadSettings();

  runApp(ProviderScope(child: MyApp(settingsController: settingsController)));
}
