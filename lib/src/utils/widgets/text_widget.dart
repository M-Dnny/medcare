import 'package:flutter/material.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';

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

class SubTitleText extends StatelessWidget {
  const SubTitleText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: Theme.of(context).colorScheme.inverseSurface));
  }
}

class LightText extends StatelessWidget {
  const LightText(this.text, {super.key});
  final String text;
  @override
  Widget build(BuildContext context) {
    return Text(text,
        style:
            Theme.of(context).textTheme.bodyMedium!.copyWith(color: greyText));
  }
}
