import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/utils/provider/auth_providers.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/button_widget.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';

class ForgotPassword extends ConsumerWidget {
  ForgotPassword({super.key});
  static const routeName = "/forgotPassword";

  final _formKey = GlobalKey<FormState>();

  void emailSubmit(String value, WidgetRef ref) {
    ref.read(forgotpassProvider.notifier).updateEmail(value);
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

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const BackBtn(),
                  thumbImg(),
                  const TitleText("Forgot"),
                  const TitleText("Password?"),
                  const SizedBox(height: 20),
                  Text(
                    "Don’t worry! it happens. Please enter your email address associated with your account.",
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .copyWith(color: greyText, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 20),
                  emailField(ref, context),
                  const SizedBox(height: 40),
                  submitBtn(ref, context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center thumbImg() {
    return Center(
      child: Image.asset(
        "assets/images/forgotPassword/forgotPass.png",
        width: 360,
        height: 400,
      ),
    );
  }

  SubmitButton submitBtn(WidgetRef ref, BuildContext context) {
    return SubmitButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {}
        // Navigator.pushNamed(context, Home.routeName);
      },
      text: "Submit",
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
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => emailSubmit(value, ref),
            decoration: InputDecoration(
                hintText: "Email ID",
                errorStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
            validator: (value) {
              return validEmail(value);
            },
          ),
        ),
      ],
    );
  }
}
