import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../main.dart';

showToast(String message) {
  speak(message);

  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

Map<String, String> ttsLanguageMap = {'en': 'en-IN', 'hi': 'hi-IN'};
