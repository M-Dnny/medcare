// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:medcare/src/screens/auth/welcome_auth.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoarding extends StatefulWidget {
  const OnBoarding({super.key});
  static const routeName = "/OnBoarding";
  @override
  State<OnBoarding> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<OnBoarding> {
  final controller = PageController();
  authWelcome() {
    Navigator.pushNamed(context, WelcomeAuth.routeName);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [const One(), const Two(), const Three(), const Four()];

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            // HEADER
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [logo(), const Spacer(), skipBtn(context)],
              ),
            ),

            // CONTENT
            pageview(pages),

            // FOOTER
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 40),
              child: Row(
                children: [
                  indicator(pages),
                  const Spacer(),
                  btn(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  TextButton skipBtn(BuildContext context) {
    return TextButton(
      onPressed: () {
        authWelcome();
      },
      child: Text('Skip Now',
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              fontWeight: FontWeight.w800,
              color: Theme.of(context).colorScheme.inverseSurface)),
    );
  }

  Widget btn() {
    slidePage() {
      controller.nextPage(
          duration: const Duration(milliseconds: 600), curve: Curves.easeInOut);
    }

    // var currentIndex = controller.page!.round();

    return FilledButton(
        style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10))),
        onPressed: () {
          controller.page!.round() != 3 ? slidePage() : authWelcome();
        },
        child: Text('Next',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                fontWeight: FontWeight.w800,
                color: Theme.of(context).canvasColor)));
  }

  SmoothPageIndicator indicator(List<StatelessWidget> pages) {
    return SmoothPageIndicator(
      controller: controller,
      count: pages.length,
      effect: ExpandingDotsEffect(
          activeDotColor: myPrimary,
          dotColor: Theme.of(context).colorScheme.outlineVariant,
          dotHeight: 10,
          dotWidth: 10,
          expansionFactor: 6),
    );
  }

  Expanded pageview(List<StatelessWidget> pages) {
    return Expanded(
      child: PageView.builder(
          itemCount: pages.length,
          controller: controller,
          itemBuilder: (_, index) {
            return pages[index];
          }),
    );
  }

  Image logo() {
    return Image.asset(
      "assets/images/logo/logo.png",
      height: 50,
      width: 50,
    );
  }
}

class One extends StatelessWidget {
  const One({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/onBoard/bottle_of_pills.png",
              width: 200,
              height: 290,
            ),
            const SizedBox(height: 30),
            const TitleText("Order Medicines"),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                  "Order your medicines easily and use coupons for best discounts and get cashback. It's a hassle-free process that saves your time and effort."),
            ),
          ],
        ),
      ),
    );
  }
}

class Two extends StatelessWidget {
  const Two({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 30),
              child: Image.asset(
                "assets/images/onBoard/delivery.png",
                width: 260,
                height: 290,
              ),
            ),
            const SizedBox(height: 30),
            const TitleText("Get the fastest medicine delivery"),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                  "Order medicines with just few clicks and you can get your orders delivered at your doorstep."),
            ),
          ],
        ),
      ),
    );
  }
}

class Three extends StatelessWidget {
  const Three({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/onBoard/online_medicine.png",
              width: 320,
              height: 320,
            ),
            const SizedBox(height: 30),
            const TitleText("Online consultation"),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                  "Now you can consult a doctor through online and consultation has made easy and convenient to access healthcare services without leaving home."),
            ),
          ],
        ),
      ),
    );
  }
}

class Four extends StatelessWidget {
  const Four({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/onBoard/calendar.png",
              width: 320,
              height: 320,
            ),
            const SizedBox(height: 30),
            const TitleText("Book appointments"),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SubText(
                  "Now you can book an appointments through online and easily schedule an appointment at your own date & time."),
            ),
          ],
        ),
      ),
    );
  }
}
