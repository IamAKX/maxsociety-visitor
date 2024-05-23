// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../widget/header.dart';

class ConfirmFlatScreen extends StatefulWidget {
  const ConfirmFlatScreen({super.key});
  static const String routePath = '/confirmFlatScreen';
  @override
  State<ConfirmFlatScreen> createState() => _ConfirmFlatScreenState();
}

class _ConfirmFlatScreenState extends State<ConfirmFlatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
    );
  }

  getBody(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(
          vertical: Constants.defaultPadding,
          horizontal: Constants.defaultPadding * 2),
      children: [
        const Header(),
        verticalGap(Constants.defaultPadding * 2),
        Text(
          AppLocalizations.of(context)!.promptLastVisit,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
