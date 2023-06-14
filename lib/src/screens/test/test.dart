// import 'package:daily_meds/main.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// // class MyWidget extends ConsumerStatefulWidget {
// //   const MyWidget({super.key});
// //   static const routeName = "/";
// //   @override
// //   ConsumerState<MyWidget> createState() => _MyWidgetState();
// // }

// // class _MyWidgetState extends ConsumerState<MyWidget> {
// //   void onSubmit(WidgetRef ref, String value) {
// //     ref.read(nameProvider.notifier).update((state) => value);
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     final name = ref.watch(nameProvider) ?? '';
// //     return Scaffold(
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text("Name: $name"),
// //             TextField(
// //               onSubmitted: (value) => onSubmit(ref, value),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// class Test extends ConsumerWidget {
//   const Test({super.key});

//   static const routeName = "/";

//   void onSubmit(WidgetRef ref, String value) {
//     // ref.read(nameProvider.notifier).update((state) => value);

//     ref.read(userProvider.notifier).updateName(value);
//   }
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // final name = ref.watch(nameProvider) ?? "";

//     // final user = ref.watch(userProvider);

//     final user = ref.watch(userProvider.select((value) => value.name));
//     return Scaffold(
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text("Name: $user"),
//             // TextField(
//             //   onChanged: (value) => onSubmit(ref, value),
//             // ),

//             LinearProgressIndicator()
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final animationProvider = StateProvider((ref) => 0.0);

class Test extends ConsumerStatefulWidget {
  const Test({super.key});

  static const routeName = "/";

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TestState();
}

class _TestState extends ConsumerState<Test>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation<double>? animation;

  @override
  void initState() {
    super.initState();

    progress();
  }

  progress() async {
    controller =
        AnimationController(duration: const Duration(seconds: 6), vsync: this);
    animation = Tween(
      begin: 0.0,
      end: 1.0,
    ).animate(controller!)
      ..addListener(() {
        ref
            .watch(animationProvider.notifier)
            .update((state) => animation!.value);
        // setState(() {});
      });
    await controller!.forward();
  }

  @override
  Widget build(BuildContext context) {
    final value = ref.watch(animationProvider.select((value) => value));
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: LinearProgressIndicator(
            value: value,
          ),
        ),
      ),
    );
  }
}
