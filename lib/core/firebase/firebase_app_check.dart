import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:flutter/foundation.dart';
class FirebaseAppCheckHelper {
  FirebaseAppCheckHelper._();

  static Future initialise() async {
    await FirebaseAppCheck.instance.activate(
      //webProvider: 'recaptcha-v3-site-key',
      androidProvider: _androidProvider(),
    );
  }

  static AndroidProvider _androidProvider() {
    if (kDebugMode) {
      return AndroidProvider.debug;
    }

    return AndroidProvider.playIntegrity;
  }
}