// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:ms_register/model/session_data.dart';
import 'package:ms_register/screens/purpose_screen.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../model/visitor_log_model.dart';
import '../model/visitor_model.dart';
import '../utils/helper_methods.dart';
import '../widget/header.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key, required this.sessionData});
  final SessionData sessionData;
  static const String routePath = '/personScreen';

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
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
            onPressed:
                _speechToText.isNotListening ? _startListening : _stopListening,
            tooltip: AppLocalizations.of(context)!.listen,
            child:
                Icon(_speechToText.isNotListening ? Icons.mic : Icons.mic_off),
          ),
          FloatingActionButton(
            onPressed: () {
              _stopListening();
              if (_lastWords.isNotEmpty) {
                widget.sessionData.log?.residentName = _lastWords;
                Navigator.of(context).pushNamed(PurposeScreen.routePath,
                    arguments: widget.sessionData);
              } else {
                showToast(AppLocalizations.of(context)!.promptPerson);
              }
            },
            tooltip: AppLocalizations.of(context)!.next,
            child: const Icon(Icons.arrow_forward),
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
            AppLocalizations.of(context)!.promptPerson,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _speechToText.isListening || _lastWords.trim().isNotEmpty
                    ? _lastWords
                    : AppLocalizations.of(context)!.tapMic,
                style: _speechToText.isListening || _lastWords.trim().isNotEmpty
                    ? TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      )
                    : const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.normal,
                      ),
              ),
            ),
          ),
          Visibility(
            visible: _speechToText.isListening,
            child: SiriWaveform.ios9(),
          ),
          verticalGap(Constants.defaultPadding),
        ],
      ),
    );
  }
}
