// ignore_for_file: avoid_print

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/auth/login.dart';
import 'package:medcare/src/screens/auth/welcome_auth.dart';
import 'package:medcare/src/screens/home/home.dart';
import 'package:medcare/src/screens/onBoarding/onBoarding.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/widgets/bottom_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart' as supabase_provider;

final supabase = Supabase.instance.client;

// CREATE ACCOUNT SERVICE

Future<void> createAccount(WidgetRef ref, BuildContext context) async {
  var get = ref.watch(signupProvider);

  try {
    const snackBar = SnackBar(
      content: Text('Register successfully'),
      behavior: SnackBarBehavior.floating,
      margin: EdgeInsets.all(16),
    );
    await supabase.auth
        .signUp(
            email: get.email_id,
            password: get.password,
            // phone: get.phone_number,
            data: {
              "fullname": get.fullname,
              "phone": get.phone_number,
            })
        .then(
          (value) => {
            ScaffoldMessenger.of(context).showSnackBar(snackBar),
            Navigator.pushNamed(context, Login.routeName),
          },
        )
        .catchError((onError) => {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(onError.message.toString())))
            });
  } catch (e) {
    debugPrint("Try Catch Error: $e");
  }
}

// LOGIN SERVICE

Future<void> loginService(WidgetRef ref, BuildContext context) async {
  var get = ref.watch(loginProvider);
  const snackBar = SnackBar(
    content: Text('Login successfully'),
    behavior: SnackBarBehavior.floating,
    margin: EdgeInsets.all(16),
  );

  try {
    await supabase.auth
        .signInWithPassword(email: get.email_id, password: get.password)
        .then(
          (value) => {
            ScaffoldMessenger.of(context).showSnackBar(snackBar),
            Navigator.pushNamed(context, Home.routeName),
          },
        )
        .catchError((onError) => {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(onError.message.toString()),
                behavior: SnackBarBehavior.floating,
                margin: const EdgeInsets.all(16),
              )),
            });
  } catch (e) {
    debugPrint("Try Catch Error: $e");
  }
}

// GET USER SESSION

getUserSession(context) async {
  var token = supabase.auth.currentSession?.accessToken;

  SharedPreferences prefs = await SharedPreferences.getInstance();

  var firstTime = prefs.getBool('first_time');

  var duration = const Duration(seconds: 1);

  if (firstTime != null && !firstTime) {
    Timer(duration, () {
      try {
        if (token != null) {
          supabase.auth.onAuthStateChange.first
              .then((value) => {
                    if (value.event == AuthChangeEvent.signedIn)
                      {
                        Navigator.pushReplacementNamed(
                            context, BottomBar.routeName),
                        // Navigator.pushReplacementNamed(context, Home.routeName),
                      }
                    else
                      {
                        Navigator.pushReplacementNamed(
                            context, WelcomeAuth.routeName),
                      }
                  })
              // ignore: body_might_complete_normally_catch_error
              .catchError((onError) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(onError.message.toString()),
              behavior: SnackBarBehavior.floating,
              margin: const EdgeInsets.all(16),
            ));
          });
        } else {
          Navigator.pushReplacementNamed(context, WelcomeAuth.routeName);
        }
      } catch (e) {
        print("Error: $e");
      }
    });
  } else {
    Timer(duration, () {
      prefs.setBool('first_time', false);
      Navigator.pushReplacementNamed(context, OnBoarding.routeName);
    });
  }
}

// Logout service

logout(context) async {
  await supabase.auth.signOut().then((value) =>
      {Navigator.pushReplacementNamed(context, WelcomeAuth.routeName)});
}

// Google login

googleLogin() async {
  await supabase.auth.signInWithOAuth(
    supabase_provider.Provider.google,
    redirectTo: "io.supabase.medcare://login-callback/",
  );
}
