import 'package:flutter/material.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton({super.key, required this.text, required this.onPressed});

  final String text;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return FilledButton(
      style: ElevatedButton.styleFrom(
          fixedSize: Size(width, 55),
          backgroundColor: myPrimary,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      onPressed: onPressed,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineLarge!.copyWith(
            fontSize: 20,
            fontWeight: FontWeight.w500,
            color: Theme.of(context).colorScheme.background),
      ),
    );
  }
}


class BackBtn extends StatelessWidget {
  const BackBtn({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        Navigator.pop(context);
      },
      style: IconButton.styleFrom(
        elevation: 5,
        shadowColor: Theme.of(context).colorScheme.onSurface,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      icon: const Icon(
        Icons.chevron_left_rounded,
      ),
    );
  }
}