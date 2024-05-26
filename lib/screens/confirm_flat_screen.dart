// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:ms_register/screens/purpose_screen.dart';
import 'package:ms_register/screens/type_screen.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../model/session_data.dart';
import '../widget/header.dart';

class ConfirmFlatScreen extends StatefulWidget {
  const ConfirmFlatScreen({super.key, required this.sessionData});
  final SessionData sessionData;
  static const String routePath = '/confirmFlatScreen';

  @override
  State<ConfirmFlatScreen> createState() => _ConfirmFlatScreenState();
}

class _ConfirmFlatScreenState extends State<ConfirmFlatScreen> {
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
            onPressed: () {
              Navigator.of(context).pushNamed(PurposeScreen.routePath,
                  arguments: widget.sessionData);
            },
            tooltip: 'Yes',
            child: const Icon(Icons.check),
          ),
          FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushNamed(TypeScreen.routePath,
                  arguments: widget.sessionData);
            },
            tooltip: 'No',
            child: const Icon(Icons.close),
          ),
        ],
      ),
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
          Text(
            AppLocalizations.of(context)!.promptLastVisit,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          verticalGap(Constants.defaultPadding * 2),
          getVisitDetailRow(
              'Property Type', widget.sessionData.log?.type ?? ''),
          getVisitDetailRow('Block', widget.sessionData.log?.block ?? ''),
          getVisitDetailRow('Flat', widget.sessionData.log?.flatNo ?? ''),
          getVisitDetailRow(
              'Resident name', widget.sessionData.log?.residentName ?? ''),
        ],
      ),
    );
  }

  getVisitDetailRow(String key, String value) {
    return Row(
      children: [
        Expanded(
          child: Text(
            key,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
            textAlign: TextAlign.right,
          ),
        ),
        horizontalGap(Constants.defaultPadding),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 18),
          ),
        )
      ],
    );
  }
}
