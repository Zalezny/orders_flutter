import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:testapp/main.dart';
import 'package:testapp/utils/utils.dart';

class CustomApp extends StatelessWidget {
  CustomApp({super.key});
  final ColorScheme schemeOfcolors = ColorScheme.fromSwatch().copyWith(
    primary: const Color.fromRGBO(228, 18, 67, 1),
  );

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
            theme: const CupertinoThemeData(
              brightness: Brightness.light,
              primaryColor: Color.fromARGB(255, 255, 0, 60),
              // textTheme: CupertinoTextThemeData(
              //     navActionTextStyle:
              //         TextStyle(color: Color.fromARGB(255, 255, 0, 60)),
              //     textStyle: TextStyle(
              //         color: CupertinoColors.black,
              //         decorationColor: Color.fromARGB(255, 255, 0, 60)))
            ),
            home: MyHomePage(title: 'Home Page'),
          )
        : MaterialApp(
            title: 'KatyaOrders',
            theme: ThemeData(
                primarySwatch: createMaterialColor(const Color(0x00e94168)),
                colorScheme: schemeOfcolors,
                fontFamily: 'Roboto',
                textTheme: ThemeData.light().textTheme.copyWith(
                      titleLarge: const TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                      titleMedium: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                      titleSmall: const TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 12),
                    )),
            home: MyHomePage(title: 'Zamówienia'),
          );
  }
}