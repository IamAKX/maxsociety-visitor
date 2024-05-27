// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';
import '../widget/header.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});
  static const String routePath = '/welcomeScreen';
  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.defaultPadding,
          horizontal: Constants.defaultPadding * 2),
      child: Column(
        children: [
          const Header(),
          verticalGap(Constants.defaultPadding * 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.welcome,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              IconButton(
                onPressed: () {
                  speak(AppLocalizations.of(context)!.welcome);
                },
                icon: Icon(Icons.volume_up_sharp),
              )
            ],
          )
        ],
      ),
    );
  }
}
