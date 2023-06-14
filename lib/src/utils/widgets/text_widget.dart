import 'package:flutter/material.dart';

class TitleText extends StatelessWidget {
  const TitleText(this.text, {super.key});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.w800,
            color: Theme.of(context).colorScheme.inverseSurface));
  }
}

class SubText extends StatelessWidget {
  const SubText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .bodyMedium!
            .copyWith(color: Theme.of(context).colorScheme.inverseSurface));
  }
}
