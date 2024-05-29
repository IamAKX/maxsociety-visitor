import 'package:flutter/material.dart';
import 'package:ms_register/model/session_data.dart';
import 'package:ms_register/screens/admin/admin_portal.dart';
import 'package:ms_register/screens/building_screen.dart';
import 'package:ms_register/screens/flat_screen.dart';
import 'package:ms_register/screens/person_screen.dart';
import 'package:ms_register/screens/phone_screen.dart';
import 'package:ms_register/screens/purpose_screen.dart';
import 'package:ms_register/screens/take_picture_screen.dart';
import 'package:ms_register/screens/type_screen.dart';
import 'package:ms_register/screens/user_name_screen.dart';
import 'package:ms_register/screens/welcome_screen.dart';

import '../screens/confirm_flat_screen.dart';
import '../screens/confirm_user_screen.dart';

class NavRoute {
  static MaterialPageRoute<dynamic> generatedRoute(RouteSettings settings) {
    switch (settings.name) {
      case PhoneScreen.routePath:
        return MaterialPageRoute(builder: (_) => const PhoneScreen());
      case TakePictureScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => TakePictureScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case UserNameScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => UserNameScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case BuildingScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => BuildingScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case TypeScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => TypeScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case FlatScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => FlatScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case PersonScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => PersonScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case PurposeScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => PurposeScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case WelcomeScreen.routePath:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());
      case ConfirmUserScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => ConfirmUserScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case ConfirmFlatScreen.routePath:
        return MaterialPageRoute(
            builder: (_) => ConfirmFlatScreen(
                  sessionData: settings.arguments as SessionData,
                ));
      case AdminPortal.routePath:
        return MaterialPageRoute(builder: (_) => const AdminPortal());

      default:
        return errorRoute();
    }
  }
}

errorRoute() {
  return MaterialPageRoute(builder: (_) {
    return const Scaffold(
      body: Center(
        child: Text('Undefined route'),
      ),
    );
  });
}
