// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/banner_card.dart';
import 'package:medcare/src/utils/widgets/product_card.dart';
import 'package:medcare/src/utils/widgets/rating_star.dart';
import 'package:medcare/src/utils/widgets/text_widget.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  static const routeName = "/home";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final email = supabase.auth.currentUser?.email;
    final name = supabase.auth.currentUser?.userMetadata!['full_name'] ??
        supabase.auth.currentUser?.userMetadata!['fullname'];

    final controller = PageController();
    final bannerList = [Banner1(), Banner2(), Banner3()];

    return Scaffold(
      appBar: Appbar(name, context, email),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // label and search button

                Row(
                  children: [
                    lableText(context),
                    const Spacer(),
                    searchBtn(),
                  ],
                ),

                // Banner Lists
                const SizedBox(height: 20),

                bannerSlider(bannerList, controller),

                const SizedBox(height: 10),

                bannerDots(controller, bannerList, context),

                // Best Deals List

                const SizedBox(height: 10),

                bestDealHeader(),

                const SizedBox(height: 10),

                bestDealGrid(),

                // bestDealProduct(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bestDealGrid() {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 5,
          mainAxisSpacing: 5,
          mainAxisExtent: 260),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (context, index) {
        return ProductCard(
          bgColor: productBg1,
          discountText: '100%',
          favIcon: Icons.favorite_rounded,
          iconColor: Colors.white,
          iconPress: () {},
          productImage: 'assets/images/home/dettol.png',
          productPrice: "\$11.33",
          productRating: '3.0',
          productTitle: 'Dettol Liquid',
        );
      },
    );
  }

  SizedBox bestDealProduct(BuildContext context) {
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
                  decoration: const BoxDecoration(
                      color: productBg1, shape: BoxShape.circle),
                ),

                const SizedBox(height: 10),

                Text(
                  "Dettol Antiseptic Liquid",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),
                const SizedBox(height: 6),

                Text(
                  "\$11.33",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: Theme.of(context).colorScheme.inverseSurface),
                ),

                const SizedBox(height: 6),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      star(),
                      star(),
                      star(),
                      star(),
                      star(),
                      const Spacer(),
                      Text(
                        "4.7",
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
              child: Image.asset("assets/images/home/dettol.png",
                  fit: BoxFit.contain, height: 104),
            ),
          ],
        ),
      ),
    );
  }

  Container star() {
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
          squash: 0,
          valleyRounding: 0,
          rotation: 0,
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
        icon: const Icon(Icons.favorite_rounded, color: Colors.white),
        onPressed: () {},
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
            "15%",
            style: Theme.of(context)
                .textTheme
                .labelSmall!
                .copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }

  bestDealHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SubTitleText("Best deals"),
        TextButton(onPressed: () {}, child: const LightText("View all")),
      ],
    );
  }

  SmoothPageIndicator bannerDots(PageController controller,
      List<BannerCard> bannerList, BuildContext context) {
    return SmoothPageIndicator(
      controller: controller,
      count: bannerList.length,
      effect: ExpandingDotsEffect(
          activeDotColor: myPrimary,
          dotColor: Theme.of(context).colorScheme.outlineVariant,
          dotHeight: 7,
          dotWidth: 6,
          expansionFactor: 6),
    );
  }

  SizedBox bannerSlider(
      List<BannerCard> bannerList, PageController controller) {
    return SizedBox(
      height: 220,
      child: PageView.builder(
          itemCount: bannerList.length,
          controller: controller,
          itemBuilder: (_, index) {
            return bannerList[index];
          }),
    );
  }

  BannerCard Banner3() {
    return BannerCard(
      bannerBgColor: banner3,
      title: 'Cash Back On Next${"\n"}Appointment',
      subtitle: 'Booking appointment',
      onPressed: () {},
      buttonLabel: 'Book Now',
      positionedBottom: -60,
      positionedRight: -20,
      imgPositionedBottom: 0,
      imgPositionedRight: 25,
      imagePath: 'assets/images/home/banner_3.png',
      imageWidth: 80,
    );
  }

  BannerCard Banner2() {
    return BannerCard(
      bannerBgColor: banner2,
      title: 'Get Instant${"\n"}Discount',
      subtitle: 'on Diabetes',
      onPressed: () {},
      buttonLabel: 'Order Now',
      positionedBottom: -60,
      positionedRight: -20,
      imgPositionedBottom: 10,
      imgPositionedRight: 30,
      imagePath: 'assets/images/home/banner_2.png',
      imageWidth: 150,
    );
  }

  BannerCard Banner1() {
    return BannerCard(
      bannerBgColor: banner1,
      title: 'FREE Delivery${"\n"}On Every 5 Orders',
      subtitle: 'Order your medicines',
      onPressed: () {},
      buttonLabel: 'Order Now',
      positionedBottom: -60,
      positionedRight: -20,
      imgPositionedBottom: 0,
      imgPositionedRight: 10,
      imagePath: 'assets/images/home/banner_1.png',
      imageWidth: 190,
    );
  }

  Appbar(name, BuildContext context, String? email) {
    return AppBar(
      forceMaterialTransparency: true,
      toolbarHeight: 100,
      leadingWidth: 90,
      leading: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Image.asset('assets/images/home/profile_pic.png'),
      ),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(name, style: Theme.of(context).textTheme.titleMedium),
          Text(email.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: greyText)),
        ],
      ),
      actions: [
        IconButton(
            onPressed: () {},
            icon:
                Image.asset('assets/images/home/Notification.png', width: 24)),
        IconButton(
            onPressed: () {},
            icon: Image.asset('assets/images/home/Cart.png', width: 24)),
        const SizedBox(width: 20),
      ],
    );
  }

  searchBtn() {
    return Container(
      height: 60,
      width: 64,
      decoration: const BoxDecoration(
        color: darkGreenbg,
        border: Border.fromBorderSide(BorderSide(
          color: Color.fromARGB(255, 227, 235, 232),
          width: 5,
        )),
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      child: const Icon(Feather.search, size: 26, color: Colors.white),
    );
  }

  lableText(BuildContext context) {
    return Text.rich(
      const TextSpan(text: "Look For Your", children: [
        TextSpan(text: "${'\n'}Healthy", style: TextStyle(color: myPrimary)),
        TextSpan(text: " Life!"),
      ]),
      style: Theme.of(context).textTheme.headlineMedium!.copyWith(
            fontWeight: FontWeight.bold,
          ),
    );
  }
}
