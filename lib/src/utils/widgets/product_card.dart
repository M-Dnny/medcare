// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/rating_star.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    required this.discountText,
    required this.iconPress,
    required this.favIcon,
    required this.iconColor,
    required this.bgColor,
    required this.productImage,
    required this.productTitle,
    required this.productPrice,
    required this.productRating,
  }) : super(key: key);

  final String discountText;
  final VoidCallback iconPress;
  final IconData favIcon;
  final Color iconColor;
  final Color bgColor;
  final String productImage;
  final String productTitle;
  final String productPrice;
  final String productRating;

  @override
  Widget build(BuildContext context) {
    var rating = double.parse(productRating);

    return SizedBox(
      height: 250,
      width: 170,
      child: Card(
        child: Stack(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),

                  // Header

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      discountLabel(context),
                      favIconBtn(),
                    ],
                  ),
                ),

                // Body
                Container(
                  height: 95,
                  width: 95,
                  decoration:
                      BoxDecoration(color: bgColor, shape: BoxShape.circle),
                ),

                const SizedBox(height: 10),

                SizedBox(
                  width: 150,
                  child: Text(
                    productTitle,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),
                const SizedBox(height: 6),

                SizedBox(
                  width: 150,
                  child: Text(
                    textAlign: TextAlign.center,
                    productPrice,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.inverseSurface),
                  ),
                ),

                const SizedBox(height: 6),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      StarWidget(rating: rating),
                      const Spacer(),
                      Text(
                        productRating,
                        style: Theme.of(context)
                            .textTheme
                            .bodyMedium!
                            .copyWith(color: greyText),
                      ),
                    ],
                  ),
                )
              ],
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 40,
              child:
                  Image.asset(productImage, fit: BoxFit.contain, height: 104),
            ),
          ],
        ),
      ),
    );
  }

  Container discountLabel(BuildContext context) {
    return Container(
      height: 24,
      width: 34,
      decoration: BoxDecoration(
        color: red,
        borderRadius: BorderRadius.circular(3),
      ),
      child: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Center(
          child: Text(
            discountText,
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  SizedBox favIconBtn() {
    return SizedBox(
      height: 35,
      width: 35,
      child: IconButton(
        style: IconButton.styleFrom(iconSize: 20, backgroundColor: red),
        icon: Icon(favIcon, color: iconColor),
        onPressed: iconPress,
      ),
    );
  }

  star() {
    return Container(
      width: 18,
      height: 18,
      margin: const EdgeInsets.only(right: 3),
      decoration: const ShapeDecoration(
        gradient: LinearGradient(
          colors: [myPrimary, Colors.black12],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          stops: [1, 0],
        ),
        shape: StarBorder(
          points: 5,
          innerRadiusRatio: 0.4,
          pointRounding: 0.3,
        ),
      ),
    );
  }
}
