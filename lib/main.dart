import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderskatya/di/dependency_injection.dart';
import 'package:orderskatya/firebase/firebase_messaging_service.dart';
import 'package:orderskatya/pages/main_page/main_page.dart';
import 'package:orderskatya/services/navigation_service.dart';
import 'package:orderskatya/themes/default_theme.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupDependencyInjection();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FirebaseMessagingService.initalization();

  final RemoteMessage? terminatedMessage =
      await FirebaseMessagingService.firebaseMessaging!.getInitialMessage();

  if (terminatedMessage != null) {
    if (terminatedMessage.data.isNotEmpty) {
      final String newOrderId = terminatedMessage.data['body'];
      NavigationService.navigateToSelectedOrderById(newOrderId);
    }
  }

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  void initState() {
    super.initState();
    FirebaseMessagingService.requestNotificationPermission();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoApp(
            navigatorKey: NavigationService.navigatorKey,
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
            navigatorKey: NavigationService.navigatorKey,
            theme: DefaultTheme().buildThemeData(),
            home: MainPage(),
          );
  }
}
