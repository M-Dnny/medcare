import 'package:flutter/material.dart';

class BannerCard extends StatelessWidget {
  const BannerCard({
    super.key,
    required this.bannerBgColor,
    required this.title,
    required this.subtitle,
    required this.onPressed,
    required this.buttonLabel,
    required this.positionedBottom,
    required this.positionedRight,
    required this.imgPositionedBottom,
    required this.imgPositionedRight,
    required this.imagePath,
    required this.imageWidth,
  });

  final Color bannerBgColor;
  final String title;
  final String subtitle;
  final VoidCallback onPressed;
  final String buttonLabel;
  final double positionedBottom;
  final double positionedRight;
  final double imgPositionedBottom;
  final double imgPositionedRight;
  final String imagePath;
  final double imageWidth;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Card(
          margin:
              const EdgeInsets.only(bottom: 30, left: 10, right: 10, top: 10),
          color: bannerBgColor,
          child: Stack(
            children: [
              Row(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 18, bottom: 18, left: 21),

                    // Labels

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                        const SizedBox(height: 5),
                        Text(subtitle,
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor)),
                        const SizedBox(height: 21),

                        // Button

                        ElevatedButton(
                          onPressed: onPressed,
                          child: Text(buttonLabel,
                              style: Theme.of(context).textTheme.labelMedium),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Positioned(
                bottom: positionedBottom,
                right: positionedRight,
                child: Container(
                  height: 175,
                  width: 175,
                  clipBehavior: Clip.antiAlias,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.fromBorderSide(BorderSide(
                      color: Colors.black26,
                      width: 5,
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
            bottom: imgPositionedBottom,
            right: imgPositionedRight,
            child: Image.asset(imagePath, width: imageWidth)),
      ],
    );
  }
}
