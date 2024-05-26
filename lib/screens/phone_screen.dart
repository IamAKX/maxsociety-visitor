// ignore_for_file: avoid_web_libraries_in_flutter

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:ms_register/main.dart';
import 'package:ms_register/model/session_data.dart';
import 'package:ms_register/model/visitor_log_model.dart';
import 'package:ms_register/model/visitor_model.dart';
import 'package:ms_register/screens/confirm_user_screen.dart';
import 'package:ms_register/screens/take_picture_screen.dart';
import 'package:ms_register/utils/api.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/utils/helper_methods.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:siri_wave/siri_wave.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:string_validator/string_validator.dart';

import '../service/api_provider.dart';
import '../widget/header.dart';

class PhoneScreen extends StatefulWidget {
  const PhoneScreen({super.key});
  static const String routePath = '/phoneScreen';
  @override
  State<PhoneScreen> createState() => _PhoneScreenState();
}

class _PhoneScreenState extends State<PhoneScreen> {
  final SpeechToText _speechToText = SpeechToText();
  late SessionData sessionData;
  bool _speechEnabled = false;
  String _lastWords = '';
  late ApiProvider _api;
  bool isInitialized = false;

  @override
  void initState() {
    super.initState();
    sessionData = SessionData(visitor: VisitorModel(), log: VisitorLogModel());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _initSpeech();
    });
  }

 
  Future<void> _speak(String text) async {
   
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
    _api = Provider.of<ApiProvider>(context);

    return Scaffold(
      body: _api.status == ApiStatus.loading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : getBody(context),
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
            onPressed: () async {
              _stopListening();
              String phoneNumber = _lastWords.replaceAll(' ', '');
              if (isNumeric(phoneNumber) && phoneNumber.length == 10) {
                sessionData.visitor?.mobileNo = phoneNumber;
                Map<String, dynamic> response = await _api
                    .getRequest(Api.getVisitorsByMobileNo + phoneNumber);

                if (_api.status == ApiStatus.success) {
                  sessionData.visitor = VisitorModel.fromMap(response['data']);
                  sessionData.log = VisitorLogModel.fromMap(
                      response['data']['lastVisitorLog']);
                  sessionData.isNewUser = false;
                  Navigator.of(context).pushNamed(ConfirmUserScreen.routePath,
                      arguments: sessionData);
                } else {
                  sessionData.isNewUser = true;
                  Navigator.of(context).pushNamed(TakePictureScreen.routePath,
                      arguments: sessionData);
                }
              } else {
                showToast(AppLocalizations.of(context)!.invalidPhoneNumber);
                _speak(AppLocalizations.of(context)!.promptPhone);
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
            AppLocalizations.of(context)!.promptPhone,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                _speechToText.isListening || _lastWords.trim().isNotEmpty
                    ? _lastWords.replaceAll(' ', '')
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
