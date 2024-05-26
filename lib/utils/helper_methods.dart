import 'package:fluttertoast/fluttertoast.dart';

showToast(String message) {
  Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.TOP_RIGHT,
      timeInSecForIosWeb: 1,
      fontSize: 16.0);
}

Map<String, String> ttsLanguageMap = {'en': 'en-IN', 'hi': 'hi-IN'};
