import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/utils/provider/auth_appwrite_provider.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/widgets/button_widget.dart';
import 'package:medcare/src/utils/widgets/footer.dart';
import 'package:medcare/src/utils/widgets/images_widget.dart';
import 'package:medcare/src/utils/widgets/text_field.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';

class Signup extends ConsumerWidget {
  static const routeName = "/signup";
  final _formKey = GlobalKey<FormState>();

  Signup({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                        imagePath: "assets/images/signup/signup.png"),
                    const SizedBox(height: 20),
                    const TitleText("Sign up"),
                    const SizedBox(height: 20),

                    // Full name field

                    nameField(ref),

                    const SizedBox(height: 20),

                    // EMAIL Form Fields

                    emailField(ref),

                    const SizedBox(height: 20),

                    // Password Form Fields

                    passwordField(ref),

                    const SizedBox(height: 24),

                    const SizedBox(height: 24),

                    submitBtn(ref, context),

                    const SizedBox(height: 24),

                    const SocialBtnFooter(),

                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  emailField(WidgetRef ref) {
    return MyTextField(
      iconPath: "assets/images/login/email_icon.png",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.emailAddress,
      hintText: "Email ID",
      onChanged: (value) => updateEmail(value, ref),
      validator: (value) => validEmail(value),
      obscureText: false,
      sufficIcon: const SizedBox(),
    );
  }

  nameField(WidgetRef ref) {
    return MyTextField(
      iconPath: "assets/images/signup/name.png",
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.name,
      hintText: "Full name",
      onChanged: (value) => updateFullname(value, ref),
      validator: (value) => validFullName(value),
      obscureText: false,
      sufficIcon: const SizedBox(),
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
      onChanged: (value) => updatePassword(value, ref),
      validator: (value) => validPassword(value),
      obscureText: obscureText,
      sufficIcon: suffixIcon,
    );
  }

  SubmitButton submitBtn(WidgetRef ref, BuildContext context) {
    return SubmitButton(
      onPressed: () async {
        if (_formKey.currentState!.validate()) {
          createAccount(ref, context);
          // createDart(ref);
        }
      },
      text: "Sign up",
    );
  }

  void updateEmail(String value, WidgetRef ref) {
    ref.read(signupProvider.notifier).updateEmail(value);
  }

  void updateFullname(String value, WidgetRef ref) {
    ref.read(signupProvider.notifier).updateFullname(value);
  }

  void updatePassword(String value, WidgetRef ref) {
    ref.read(signupProvider.notifier).updatePassword(value);
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

  validFullName(value) {
    if (value.isEmpty) {
      return "Enter full Name";
    }
    return null;
  }

  validPassword(value) {
    var regx =
        RegExp(r"^.*(?=.{6,})(?=.*[a-zA-Z])(?=.*\d)(?=.*[!@#&$%&? ]).*$");
    if (value.isEmpty) {
      return "Enter your password";
    }
    if (!regx.hasMatch(value)) {
      return "Password is not strong enough";
    }

    return null;
  }
}
