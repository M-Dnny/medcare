// ignore_for_file: avoid_print, body_might_complete_normally_catch_error

import 'dart:async';
import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/auth/login.dart';
import 'package:medcare/src/screens/auth/welcome_auth.dart';
import 'package:medcare/src/screens/onBoarding/onBoarding.dart';
import 'package:medcare/src/screens/splash/splash.dart';
import 'package:medcare/src/utils/constant/constant.dart';
import 'package:medcare/src/utils/provider/auth_appwrite_provider.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/widgets/bottom_bar.dart';
import 'package:medcare/src/utils/widgets/snack_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dart_appwrite/dart_appwrite.dart' as dartAppwrite;

var dartClient = dartAppwrite.Client();

Future<void> createDart(ref) async {
  dartClient
      .setEndpoint(AppwriteConstant.endPoint)
      .setProject(AppwriteConstant.projectId)
      .setKey(AppwriteConstant.apikey);

  final users = dartAppwrite.Users(dartClient);
  print('Running Create User API');
  try {
    final get = ref.watch(signupProvider);
    final response = await users.create(
      userId: ID.unique(),
      email: get.email_id,
      password: get.password,
    );
    print(response.toMap());
  } on AppwriteException catch (e) {
    print(e.message);
  }
}

// CREATE ACCOUNT SERVICE

Future<void> createAccount(WidgetRef ref, BuildContext context) async {
  try {
    final account = Account(ref.watch(appwriteClientProvider));
    final get = ref.watch(signupProvider);
    await account
        .create(
          userId: ID.unique(),
          email: get.email_id,
          password: get.password,
          name: get.fullname,
        )
        .then((value) => {
              showSnackBar(context, "Register successfully"),
              Navigator.pushNamed(context, Login.routeName),
            });
  } on AppwriteException catch (e) {
    var error = e.message.toString();
    showSnackBar(context, error);
  }
}

// Login Future Provider

Future<void> loginService(WidgetRef ref, BuildContext context) async {
  try {
    final account = Account(ref.watch(appwriteClientProvider));
    final get = ref.watch(loginProvider);
    await account
        .createEmailSession(email: get.email_id, password: get.password)
        .then((value) => {
              getUserInfo(ref),
              showSnackBar(context, "Login successfully"),
              Navigator.pushNamed(context, BottomBar.routeName),
            });
  } on AppwriteException catch (e) {
    var error = e.message.toString();
    showSnackBar(context, error);
  }
}

// GET USER SESSION

getUserSession(context, ref) async {
  try {
    final account = Account(ref.watch(appwriteClientProvider));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data;
    var firstTime = prefs.getBool('first_time');
    if (firstTime != null && !firstTime) {
      await account.get().then((value) => {
            if (value.$id != "")
              {
                data = jsonEncode(value.toMap()),
                prefs.setString("user_session", data),
                ref.watch(nameProvider.notifier).update((state) => value.name),
                ref
                    .watch(emailProvider.notifier)
                    .update((state) => value.email),
                Navigator.pushReplacementNamed(context, BottomBar.routeName),
              }
            else
              {
                Navigator.pushReplacementNamed(context, WelcomeAuth.routeName),
              }
          });
    } else {
      prefs.setBool('first_time', false);
      Navigator.pushReplacementNamed(context, OnBoarding.routeName);
    }
  } on AppwriteException catch (e) {
    // var error = e.message.toString();
    Navigator.pushReplacementNamed(context, WelcomeAuth.routeName);
    // showSnackBar(context, error);
  }
}

getUserInfo(ref) async {
  try {
    final account = Account(ref.watch(appwriteClientProvider));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data;

    await account.get().then((value) => {
          {
            data = jsonEncode(value.toMap()),
            prefs.setString("user_session", data),
            ref.watch(nameProvider.notifier).update((state) => value.name),
            ref.watch(emailProvider.notifier).update((state) => value.email),
          }
        });
  } catch (e) {
    debugPrint(e.toString());
  }
}

// Logout service

logout(context, ref) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  final account = Account(ref.watch(appwriteClientProvider));
  await account.deleteSession(sessionId: 'current');
  await prefs.clear();
  Navigator.pushReplacementNamed(context, SplashScreen.routeName);
}

// Google login

googleLogin() async {}
