import 'package:flutter/material.dart';

class AuthProfileImg extends StatelessWidget {
  const AuthProfileImg({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Image.asset(
        imagePath,
        width: 290,
        height: 210,
      ),
    );
  }
}
