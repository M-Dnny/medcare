import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/model/login_model.dart';
import 'package:medcare/src/model/signup_model.dart';

// State provider for splash screen progress bar

final progressProvider = StateProvider((ref) => 0.0);

// State Notifier Provider for login Form

final loginProvider =
    StateNotifierProvider<LoginNotifier, LoginModel>((ref) => LoginNotifier());

// state Notifier Provider for Signup Form

final signupProvider = StateNotifierProvider<SignupNotifier, SignupModel>(
    (ref) => SignupNotifier());
