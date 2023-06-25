import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/auth/forgot_password.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/widgets/button_widget.dart';
import 'package:medcare/src/utils/widgets/footer.dart';
import 'package:medcare/src/utils/widgets/images_widget.dart';
import 'package:medcare/src/utils/widgets/text_field.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';

class Login extends ConsumerWidget {
  Login({super.key});
  static const routeName = "/login";

  final _formKey = GlobalKey<FormState>();

  void emailSubmit(String value, WidgetRef ref) {
    ref.read(loginProvider.notifier).updateEmail(value);
  }

  void passwordSubmit(String value, WidgetRef ref) {
    ref.read(loginProvider.notifier).updatePassword(value);
  }

  validEmail(value) {
    var regx = RegExp(
        r"^[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*@[a-zA-Z0-9]+(?:\.[a-zA-Z0-9]+)*$");
    if (value.isEmpty) {
      return "Enter your email address";
    }
    if (!regx.hasMatch(value)) {
      return "Enter valid email address";
    }
    return null;
  }

  validPassword(value) {
    if (value.isEmpty) {
      return "Enter your password";
    }

    return null;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const BackBtn(),
                    const AuthProfileImg(
                        imagePath: "assets/images/login/login.png"),
                    const SizedBox(height: 20),
                    const TitleText("Login"),
                    const SizedBox(height: 20),

                    // EMAIL Form Fields

                    emailField(ref),

                    const SizedBox(height: 20),

                    // Password Form Fields

                    passwordField(ref),

                    const SizedBox(height: 24),

                    submitBtn(ref, context),
                    const SizedBox(height: 20),

                    // Forgot Password

                    forgotPassword(context),

                    SizedBox(height: height / 13.9),

                    const SocialBtnFooter()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center forgotPassword(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          Navigator.pushNamed(context, ForgotPassword.routeName);
        },
        child: Text("Forgot password?",
            style: Theme.of(context)
                .textTheme
                .bodyLarge!
                .copyWith(color: Theme.of(context).colorScheme.tertiary)),
      ),
    );
  }

  SubmitButton submitBtn(WidgetRef ref, BuildContext context) {
    return SubmitButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          loginService(ref, context);
        }
        // Navigator.pushNamed(context, Home.routeName);
      },
      text: "Login",
    );
  }

  passwordField(WidgetRef ref) {
    bool obscureText = ref.watch(passwordVisibleProvider);
    var obscureTextUpdate = ref.watch(passwordVisibleProvider.notifier);
    const visibleIcon = Icon(Icons.visibility_rounded);
    const visibleoffIcon = Icon(Icons.visibility_off_rounded);
    final suffixIcon = IconButton(
      onPressed: () {
        obscureTextUpdate.state = !obscureText;
      },
      icon: obscureText ? visibleoffIcon : visibleIcon,
    );
    return MyTextField(
      iconPath: "assets/images/login/pass_icon.png",
      textInputAction: TextInputAction.done,
      keyboardType: TextInputType.visiblePassword,
      hintText: "Password",
      onChanged: (value) => passwordSubmit(value, ref),
      validator: (value) => validPassword(value),
      obscureText: obscureText,
      sufficIcon: suffixIcon,
    );
  }

  emailField(WidgetRef ref) {
    return MyTextField(
      iconPath: "assets/images/login/email_icon.png",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      hintText: "Email ID",
      onChanged: (value) => emailSubmit(value, ref),
      validator: (value) => validEmail(value),
      obscureText: false,
      sufficIcon: const SizedBox(),
    );
  }
}
