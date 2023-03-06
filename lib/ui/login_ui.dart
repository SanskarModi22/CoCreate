import 'package:flutter/material.dart';

import '../style/colors.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const imageAsset = 'assets/images/g-logo-2.png';
    return Scaffold(
      body: Center(
        child: ElevatedButton.icon(
          onPressed: () => {},
          icon: Image.asset(
            imageAsset,
            height: 20,
          ),
          label: const Text(
            'Sign in with Google',
            style: TextStyle(
              color: kBlackColor,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: kWhiteColor,
            minimumSize: const Size(150, 50),
          ),
        ),
      ),
    );
  }
}
