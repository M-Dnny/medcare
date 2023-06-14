import 'package:flutter/material.dart';
import 'package:medcare/src/screens/auth/login.dart';
import 'package:medcare/src/screens/auth/signup.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/button_widget.dart';
import 'package:medcare/src/utils/widgets/footer.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';

class WelcomeAuth extends StatelessWidget {
  const WelcomeAuth({super.key});
  static const routeName = "/welcomeAuth";
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                logo(),
                const SizedBox(height: 100),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const TitleText("Hey,"),
                    const TitleText("Login now"),
                    const SizedBox(height: 20),
                    signupText(context),

                    SizedBox(height: height / 7),
                    // Login Btn

                    SubmitButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Login.routeName);
                      },
                      text: "Login",
                    ),
                    const SizedBox(height: 30),
                    // Sign up Btn
                    SubmitButton(
                      onPressed: () {
                        Navigator.pushNamed(context, Signup.routeName);
                      },
                      text: "Sign up",
                    ),

                    SizedBox(height: height / 6.3),

                    // Divider

                    const SocialBtnFooter(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  RichText signupText(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: "If you are new ",
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: myPrimary, fontWeight: FontWeight.bold),
        children: [
          TextSpan(
            text: "/ Sign up",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
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
