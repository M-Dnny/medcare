// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';
import 'package:medcare/src/utils/theme/color_schemes.g.dart';
import 'package:medcare/src/utils/widgets/banner_card.dart';
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
    final name = supabase.auth.currentUser?.userMetadata!['full_name'];

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
              ],
            ),
          ),
        ),
      ),
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
