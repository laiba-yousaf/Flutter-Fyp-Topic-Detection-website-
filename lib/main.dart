import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:topicdetectionweb/app/app.bottomsheets.dart';
import 'package:topicdetectionweb/app/app.dialogs.dart';
import 'package:topicdetectionweb/app/app.locator.dart';

import 'package:stacked_services/stacked_services.dart';
import 'package:topicdetectionweb/app/app.router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyDYC0SABhr3fWI-yhGrHjgU1stKnxtWjPw",
        authDomain: "topicdetection-93c2e.firebaseapp.com",
        projectId: "topicdetection-93c2e",
        storageBucket: "topicdetection-93c2e.appspot.com",
        messagingSenderId: "770365428478",
        appId: "1:770365428478:web:2a95ea34876c1277778baf",
        measurementId: "G-NWZ7PDFMBS"
      ),
    );

    await setupLocator();
    setupDialogUi();
    setupBottomSheetUi();
    runApp(const MainApp());
  } catch (error) {
    log("Firebase initialization error: $error");
  }
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Routes.startupView,
      debugShowCheckedModeBanner: false,
      onGenerateRoute: StackedRouter().onGenerateRoute,
      navigatorKey: StackedService.navigatorKey,
      navigatorObservers: [
        StackedService.routeObserver,
      ],
    );
  }
}
