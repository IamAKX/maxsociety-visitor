// ignore_for_file: depend_on_referenced_packages, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:ms_register/l10n/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ms_register/model/session_data.dart';
import 'package:ms_register/screens/phone_screen.dart';
import 'package:ms_register/screens/take_picture_screen.dart';
import 'package:ms_register/utils/router.dart';
import 'package:provider/provider.dart';
import 'dart:html';

import 'screens/confirm_flat_screen.dart';
import 'service/api_provider.dart';

void main() {
  runApp(const MyApp());
}

String language = 'en';
final navigatorKey = GlobalKey<NavigatorState>();

String getParams(String param) {
  var uri = Uri.dataFromString(window.location.href);
  Map<String, String> params = uri.queryParameters;
  return params[param] ?? 'en';
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    language = getParams('lang');
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (BuildContext context) => ApiProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'MaxSociety',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          scaffoldBackgroundColor: Colors.white,
          useMaterial3: true,
        ),
        home: const PhoneScreen(),
        navigatorKey: navigatorKey,
        onGenerateRoute: NavRoute.generatedRoute,
        supportedLocales: L10n.all,
        locale: Locale(language),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate
        ],
      ),
    );
  }
}
