import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/model/forgot_pass_model.dart';
import 'package:medcare/src/model/login_model.dart';
import 'package:medcare/src/model/signup_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

// State provider for splash screen progress bar

final progressProvider = StateProvider((ref) => 0.0);

// State Notifier Provider for login Form

final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginModel>((ref) => LoginNotifier());

// state Notifier Provider for Signup Form

final signupProvider = StateNotifierProvider<SignupNotifier, SignupModel>(
    (ref) => SignupNotifier());

// Password Visible Provider
final passwordVisibleProvider = StateProvider((ref) => true);
// state Notifier Provider for forgot Password

final forgotpassProvider =
    StateNotifierProvider<ForgotPasswordNotifier, ForgotPasswordModel>(
        (ref) => ForgotPasswordNotifier());

final userSessionProvider = Provider((ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  var data = jsonDecode(prefs.get('user_session').toString());

  print(data);

  // ref.watch(emailProvider.notifier).update((state) => data['providerUid']);
  // ref.watch(emailProvider.notifier).update((state) => data['']);
});

final emailProvider = StateProvider<String>((ref) => "");
final nameProvider = StateProvider<String>((ref) => "");
