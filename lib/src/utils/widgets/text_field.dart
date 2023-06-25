// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  const MyTextField({
    Key? key,
    required this.iconPath,
    required this.textInputAction,
    required this.keyboardType,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    required this.sufficIcon,
    required this.obscureText,
  }) : super(key: key);

  final String iconPath;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final ValueChanged onChanged;
  final String hintText;
  final String? Function(String?) validator;
  final Widget sufficIcon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(iconPath, fit: BoxFit.contain, height: 26, width: 26),
        const SizedBox(width: 20),
        Expanded(
          child: TextFormField(
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            onChanged: onChanged,
            obscureText: obscureText,
            decoration: InputDecoration(
                suffixIcon: sufficIcon,
                hintText: hintText,
                errorStyle: Theme.of(context)
                    .textTheme
                    .labelSmall!
                    .copyWith(color: Theme.of(context).colorScheme.error)),
            validator: validator,
          ),
        ),
      ],
    );
  }
}
