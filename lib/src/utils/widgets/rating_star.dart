import 'package:flutter/material.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';

class StarWidget extends StatelessWidget {
  const StarWidget({Key? key, required this.rating}) : super(key: key);

  final double rating; // the rating value from 0 to 5

  @override
  Widget build(BuildContext context) {
    // calculate how many stars are fully yellow
    int fullStars = rating.floor();
    // calculate how much of the next star is yellow
    double partialStar = rating - fullStars;
    // calculate how many stars are fully grey
    int emptyStars = 5 - fullStars - (partialStar > 0 ? 1 : 0);
    // create a list of star widgets with different gradients
    List<Widget> stars = [];
    for (int i = 0; i < fullStars; i++) {
      stars.add(StarWidget._star(myPrimary));
    }
    if (partialStar > 0) {
      stars.add(StarWidget._star(myPrimary, Colors.grey, partialStar));
    }
    for (int i = 0; i < emptyStars; i++) {
      stars.add(StarWidget._star(Colors.grey));
    }
    // return a row of star widgets
    return Row(
      children: stars,
    );
  }

  // a helper method to create a single star widget with a gradient
  static Widget _star(Color startColor, [Color? endColor, double? fraction]) {
    return Container(
      margin: const EdgeInsets.only(right: 3),
      width: 18,
      height: 18,
      decoration: ShapeDecoration(
        shape: const StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          pointRounding: 0.3,
        ),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            startColor,
            endColor ?? startColor,
          ],
          stops: fraction != null ? [fraction, fraction] : null,
        ),
      ),
    );
  }
}
