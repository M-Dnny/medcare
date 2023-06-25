import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/screens/home/home.dart';
import 'package:medcare/src/utils/provider/bottom_bar_provider.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';

class BottomBar extends ConsumerWidget {
  const BottomBar({super.key});
  static const routeName = "/bottomBar";

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var selectedPageIndex = ref.watch(bottomBarProvider);

    selectedPageFun(value) {
      ref.read(bottomBarProvider.notifier).state = value;
    }

    var destinations = [
      // HOME

      NavigationDestination(
          selectedIcon: Image.asset(
              'assets/images/bottomBarIcons/home_filled.png',
              fit: BoxFit.contain,
              width: 20),
          icon: Image.asset('assets/images/bottomBarIcons/home_outlined.png',
              fit: BoxFit.contain, width: 20),
          label: ""),

      // ORDER

      NavigationDestination(
          selectedIcon: Image.asset(
              'assets/images/bottomBarIcons/order_filled.png',
              fit: BoxFit.contain,
              width: 20),
          icon: Image.asset('assets/images/bottomBarIcons/order_outlined.png',
              fit: BoxFit.contain, width: 20),
          label: ""),

      // OFFER

      NavigationDestination(
          selectedIcon: Image.asset(
              'assets/images/bottomBarIcons/offer_filled.png',
              fit: BoxFit.contain,
              width: 24),
          icon: Image.asset('assets/images/bottomBarIcons/offer_outlined.png',
              fit: BoxFit.contain, width: 24),
          label: ""),

      // Profile

      NavigationDestination(
          selectedIcon: Image.asset(
              'assets/images/bottomBarIcons/profile_filled.png',
              fit: BoxFit.contain,
              width: 20),
          icon: Image.asset('assets/images/bottomBarIcons/profile_outlined.png',
              fit: BoxFit.contain, width: 20),
          label: ""),
    ];

    var screenList = [
      const Home(),
      Center(
        child: ElevatedButton(onPressed: () {}, child: const Text("GET DATA")),
      ),
      Center(
        child: ElevatedButton(
            onPressed: () {
              logout(context, ref);
            },
            child: const Text("Logout")),
      ),
      const Center(
        child: Text("Screen 4"),
      ),
    ];
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPageIndex,
        onDestinationSelected: (value) {
          selectedPageFun(value);
        },
        labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
        indicatorColor: Colors.tealAccent,
        elevation: 10,
        shadowColor: Theme.of(context).colorScheme.onBackground,
        surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
        destinations: destinations,
      ),
      body: screenList[selectedPageIndex],
    );
  }
}
