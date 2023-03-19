import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:orderskatya/di/dependency_injection.dart';
import 'package:orderskatya/pages/main_page/main_page.dart';
import 'package:orderskatya/themes/default_theme.dart';

void main() {
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
