import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medcare/src/utils/provider/providers.dart';
import 'package:medcare/src/utils/services/authService/auth_service.dart';

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
    final name = supabase.auth.currentUser?.userMetadata!['fullname'];
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Email: $email"),
              Text("Name: $name"),
            ],
          ),
        ),
      ),
    );
  }
}
