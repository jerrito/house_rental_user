import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:house_rental/core/firebase/firebase_app_check.dart';
import 'package:house_rental/core/route/go_router.dart';
import 'package:house_rental/core/theme/app_theme.dart';
import 'package:oktoast/oktoast.dart';
import './firebase_options.dart';
import './locator.dart';

void main() async {
  
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([

   DeviceOrientation.portraitDown,
   DeviceOrientation.portraitUp 
  ]);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
   await FirebaseAppCheckHelper.initialise();
   initDependencies();

  runApp(OKToast(
    child: MaterialApp.router(
      routerConfig: goRouter(),
      debugShowCheckedModeBanner: false,
        //home: const ConnectionPage(),
         theme: appTheme,),
  ));
}

