// ignore_for_file: avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:ms_register/model/visitor_model.dart';
import 'package:ms_register/screens/welcome_screen.dart';

import 'package:ms_register/utils/constants.dart';
import 'package:ms_register/utils/helper_methods.dart';
import 'package:ms_register/widget/gaps.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:siri_wave/siri_wave.dart';

import '../model/session_data.dart';
import '../service/api_provider.dart';
import '../utils/api.dart';
import '../widget/header.dart';

class PurposeScreen extends StatefulWidget {
  const PurposeScreen({super.key, required this.sessionData});
  final SessionData sessionData;
  static const String routePath = '/purposeScreen';

  @override
  State<PurposeScreen> createState() => _PurposeScreenState();
}

class _PurposeScreenState extends State<PurposeScreen> {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';
  late ApiProvider _api;

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
              if (_lastWords.isNotEmpty) {
                widget.sessionData.log?.visitPurpose = _lastWords;
                if (widget.sessionData.isNewUser ?? true) {
                  Map<String, dynamic> resp = await _api.postRequest(
                      Api.createVisitor,
                      widget.sessionData.visitor?.toMap() ?? {});
                  if (_api.status == ApiStatus.success) {
                    widget.sessionData.visitor =
                        VisitorModel.fromMap(resp['data']);
                  } else {
                    showToast(resp['message']);
                  }
                }

                widget.sessionData.log?.visitorId =
                    widget.sessionData.visitor?.id;
                Map<String, dynamic> req =
                    widget.sessionData.log?.toMap() ?? {};
                req.remove('createdOn');
                req.remove('updatedOn');
                req.remove('id');
                req.remove('visitStatus');
                Map<String, dynamic> resp =
                    await _api.postRequest(Api.createVisitorLogs, req);
                if (_api.status == ApiStatus.success) {
                  Navigator.of(context).pushNamed(WelcomeScreen.routePath,
                      arguments: widget.sessionData);
                } else {
                  showToast(resp['message']);
                }
              } else {
                showToast(AppLocalizations.of(context)!.promptPurpose);
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
            AppLocalizations.of(context)!.promptPurpose,
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
