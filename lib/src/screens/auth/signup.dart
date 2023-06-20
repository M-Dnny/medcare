import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/auth/login.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/widgets/button_widget.dart';
import 'package:medcare/src/utils/widgets/footer.dart';
import 'package:medcare/src/utils/widgets/images_widget.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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

                    nameField(ref, context),

                    const SizedBox(height: 20),

                    // EMAIL Form Fields

                    emailField(ref, context),

                    const SizedBox(height: 20),

                    // Password Form Fields

                    passwordField(ref),

                    const SizedBox(height: 24),

                    // Phone Form Fields

                    phoneField(ref, context),

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

  Row emailField(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/login/email_icon.png',
            fit: BoxFit.contain, height: 24, width: 24),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => updateEmail(value, ref),
            decoration: InputDecoration(
                hintText: "Email ID",
                errorStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
            validator: (value) => validEmail(value),
          ),
        ),
      ],
    );
  }

  Row nameField(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/signup/name.png',
            fit: BoxFit.contain, height: 26, width: 26),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.name,
            onChanged: (value) => updateFullname(value, ref),
            decoration: InputDecoration(
                hintText: "Full name",
                errorStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
            validator: (value) => validFullName(value),
          ),
        ),
      ],
    );
  }

  Row passwordField(WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/login/pass_icon.png',
            fit: BoxFit.contain, height: 24, width: 24),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.visiblePassword,
            onChanged: (value) => updatePassword(value, ref),
            decoration: const InputDecoration(
              hintText: "Password",
            ),
            validator: (value) => validPassword(value),
          ),
        ),
      ],
    );
  }

  Row phoneField(WidgetRef ref, BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset('assets/images/signup/phone.png',
            fit: BoxFit.contain, height: 26, width: 26),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.phone,
            maxLength: 10,
            onChanged: (value) => updatePhoneNumber(value, ref),
            decoration: InputDecoration(
                hintText: "Phone number",
                errorStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
            validator: (value) => validPhoneNumber(value),
          ),
        ),
      ],
    );
  }

  SubmitButton submitBtn(WidgetRef ref, BuildContext context) {
    return SubmitButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          debugPrint("ERROR: Failed to");
          createAccount(ref, context);
        }
        // Navigator.pushNamed(context, Home.routeName);
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

  void updatePhoneNumber(String value, WidgetRef ref) {
    ref.read(signupProvider.notifier).updatePhoneNumber(value);
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

  validPhoneNumber(value) {
    var regx = RegExp(r"^[7-9][0-9]{9}$");
    if (value.isEmpty) {
      return "Enter your phone number";
    }
    if (!regx.hasMatch(value)) {
      return "Enter valid phone number";
    }
    return null;
  }
}
