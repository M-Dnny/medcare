import 'package:flutter/material.dart';
import 'package:medcare/src/screens/auth/forgot_password.dart';
import 'package:medcare/src/screens/auth/login.dart';
import 'package:medcare/src/screens/auth/signup.dart';
import 'package:medcare/src/screens/auth/welcome_auth.dart';
import 'package:medcare/src/screens/home/home.dart';
import 'package:medcare/src/screens/onBoarding/onBoarding.dart';
import 'package:medcare/src/screens/splash/splash.dart';
import 'package:medcare/src/utils/widgets/bottom_bar.dart';
import 'package:page_transition/page_transition.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings, settingsController) {
  switch (routeSettings.name) {
    case SplashScreen.routeName:
      // return MaterialPageRoute(builder: (_) => const SplashScreen());
      return PageTransition(
        child: const SplashScreen(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    case OnBoarding.routeName:
      // return MaterialPageRoute(builder: (_) => const OnBoarding());
      return PageTransition(
        child: const OnBoarding(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    case WelcomeAuth.routeName:
      return PageTransition(
        child: const WelcomeAuth(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );
    case Login.routeName:
      return PageTransition(
        child: Login(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );
    case Home.routeName:
      return PageTransition(
        child: const Home(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    case Signup.routeName:
      return PageTransition(
        child: Signup(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    case ForgotPassword.routeName:
      return PageTransition(
        child: ForgotPassword(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    case BottomBar.routeName:
      return PageTransition(
        child: const BottomBar(),
        type: PageTransitionType.fade,
        settings: routeSettings,
        duration: const Duration(milliseconds: 600),
      );

    default:
      return MaterialPageRoute(
          builder: (_) => const Scaffold(
                  body: Center(
                      child: Text(
                "No Screen Available 😴",
                style: TextStyle(fontSize: 20),
              ))));
  }
}
