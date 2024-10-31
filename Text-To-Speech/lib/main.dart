import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'Screens/SplashScreen.dart';

Future<void> main() async{
  /// FIREBASE INITIALIZATION
  WidgetsFlutterBinding.ensureInitialized();
  Platform.isAndroid?
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDp1mKl863wOJHVYSMFkYLi4gfrK2IyiRE",			// Current Key    (App Level googleservices.json)
      appId: "1:942596985240:android:decab3688179cf1284dbed", // mobilesdk_app_id  (App Level googleservices.json)
      messagingSenderId: "942596985240",					            // project_number	 (App Level googleservices.json)
      projectId: "text-to-speech-92fb4",						          // project_id        (App Level googleservices.json)
    ),
  ): await Firebase.initializeApp();


  /// ONE SIGNAL INITIALIZATION
  OneSignal.initialize("ff543914-f903-4f0d-a5ac-2fc53877281d");
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.Notifications.requestPermission(true);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "TextToSpeech",
      home: SplashScreen(),
    );
  }
}
