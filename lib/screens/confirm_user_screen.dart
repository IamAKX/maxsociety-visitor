// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:ms_register/model/session_data.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../utils/helper_methods.dart';
import '../widget/header.dart';
import 'welcome_screen.dart';

class ConfirmUserScreen extends StatefulWidget {
  const ConfirmUserScreen({super.key, required this.sessionData});
  final SessionData sessionData;

  static const String routePath = '/confirmUserScreen';
  @override
  State<ConfirmUserScreen> createState() => _ConfirmUserScreenState();
}

class _ConfirmUserScreenState extends State<ConfirmUserScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initSpeech());
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: getBody(context),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'Yes',
            child: Icon(Icons.check),
          ),
          FloatingActionButton(
            onPressed: () {},
            tooltip: 'No',
            child: Icon(Icons.close),
          ),
        ],
      ),
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
          AppLocalizations.of(context)!.promptUserIdentity,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        )
      ],
    );
  }
}
