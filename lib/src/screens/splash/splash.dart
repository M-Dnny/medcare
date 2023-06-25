import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/onBoarding/onBoarding.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';

class SplashScreen extends ConsumerStatefulWidget {
  static const routeName = "/";
  const SplashScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(milliseconds: 700), () {
      progress();
    });
  }

  progress() async {
    controller =
        AnimationController(duration: const Duration(seconds: 4), vsync: this);
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller!)
      ..addListener(() {
        ref
            .watch(progressProvider.notifier)
            .update((state) => animation!.value);
      })
      ..addStatusListener((status) {
        status.name == "completed" ? onBoard() : "";
      });
    await controller!.forward();
  }

  onBoard() {
    getUserSession(context, ref);
    // Navigator.pushReplacementNamed(context, OnBoarding.routeName);
    // ref.watch(progressProvider.notifier).dispose();
  }

  onHome() {
    Navigator.pushReplacementNamed(context, "home.routeName");
    // ref.watch(progressProvider.notifier).dispose();
  }

  @override
  void dispose() {
    controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [logo(), const SizedBox(height: 26), indicator(context)],
        ),
      ),
    );
  }

  Padding indicator(BuildContext context) {
    final value = ref.watch(progressProvider.select((value) => value));
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: LinearProgressIndicator(
            value: value,
            backgroundColor: Theme.of(context).colorScheme.outlineVariant,
            color: myPrimary,
          )),
    );
  }

  Image logo() {
    return Image.asset(
      "assets/images/logo/splash_logo.png",
      height: 160,
      width: 240,
    );
  }

  Widget titleText() {
    return RichText(
      text: TextSpan(
        text: "Daily",
        style: Theme.of(context)
            .textTheme
            .displayMedium!
            .copyWith(color: myPrimary, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "Meds",
            style: Theme.of(context)
                .textTheme
                .displayMedium!
                .copyWith(color: mySecondary, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
