import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderskatya/di/dependency_injection.dart';
import 'package:orderskatya/firebase/firebase_messaging_service.dart';
import 'package:orderskatya/pages/main_page/main_page.dart';
import 'package:orderskatya/themes/default_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {}
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService.initalization(backgroundMessageHandler);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    setupDependencyInjection();
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              DefaultMaterialLocalizations.delegate,
              DefaultWidgetsLocalizations.delegate,
              DefaultCupertinoLocalizations.delegate,
            ],
            title: 'Flutter Demo',
            theme: DefaultTheme().buildCupertinoThemeData(),
            home: MainPage(),
          )
        : MaterialApp(
            title: 'KatyaOrders',
            theme: DefaultTheme().buildThemeData(),
            home: MainPage(),
          );
  }
}
