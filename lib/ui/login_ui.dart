// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import '../repository/auth_repository.dart';
import '../style/colors.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});
  void signInWithGoogle(WidgetRef ref, BuildContext context) async {
    final sMessenger = ScaffoldMessenger.of(context);
    final navigator = Routemaster.of(context);
    final errorModel =
        await ref.read(authRepositoryProvider).signInWithGoogle();
    if (errorModel.error == null) {
      ref.read(userProvider.notifier).update((state) => errorModel.data);
      navigator.push('/');
    } else {
      sMessenger.showSnackBar(SnackBar(
        content: Text(errorModel.error!),
      ));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        body: Center(
            child: ElevatedButton.icon(
      onPressed: () => signInWithGoogle(ref, context),
      icon: Image(
        image: AssetImage("assets/images/g-logo-2.png"),
        height: 40,
        width: 40,
      ),
      label: const Text(
        "Sign in With Google",
        style: TextStyle(color: kBlackColor),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: kWhiteColor,
        minimumSize: const Size(150, 50),
      ),
    )));
  }
}
