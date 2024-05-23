import 'package:flutter/material.dart';

import '../utils/constants.dart';
import 'gaps.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/image/logo_256.png',
          width: 60,
          height: 60,
        ),
        horizontalGap(Constants.defaultPadding),
        const Text(
          'MaxSociety',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ],
    );
  }
}
