import 'package:flutter/material.dart';

class SocialBtnFooter extends StatelessWidget {
  const SocialBtnFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(
                child: Divider(
              endIndent: 15,
            )),
            Text(
              "or",
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            const Expanded(
                child: Divider(
              indent: 15,
            )),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/facebook_icon.png',
                fit: BoxFit.contain,
                height: 40,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/google_icon.png',
                fit: BoxFit.contain,
                height: 40,
              ),
            ),
            GestureDetector(
              onTap: () {},
              child: Image.asset(
                'assets/images/apple_icon.png',
                fit: BoxFit.contain,
                height: 40,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
