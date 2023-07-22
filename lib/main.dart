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
  String newOrderId = "";
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  setupDependencyInjection();

  FirebaseMessagingService.initalization();

  final RemoteMessage? terminatedMessage =
      await FirebaseMessagingService.firebaseMessaging!.getInitialMessage();

  if (terminatedMessage != null) {
    if (terminatedMessage.data.isNotEmpty) {
      newOrderId = terminatedMessage.data['body'];
    }
  }
  FirebaseMessagingService.terminatedId = newOrderId;

  runApp(MyApp(starterId: newOrderId));
}

class MyApp extends StatefulWidget {
  final String starterId;
  const MyApp({super.key, required this.starterId});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseMessagingService.requestNotificationPermission();
    // Provider.of<TerminatedMessageProvider>(context).setOrderId(widget.starterId);
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
            title: 'Order Katya',
            theme: DefaultTheme().buildCupertinoThemeData(),
            home: const MainPage(),
          )
        : MaterialApp(
            title: "Order Katya",
            navigatorKey: NavigationService.navigatorKey,
            theme: DefaultTheme().buildThemeData(),
            home: const MainPage(),
          );
  }
}
