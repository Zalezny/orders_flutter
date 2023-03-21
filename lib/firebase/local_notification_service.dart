import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    const InitializationSettings initializationSettings =
         InitializationSettings(
      android: AndroidInitializationSettings(
        'ic_logo',
      ),
    );

    notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationResponse,
    );
  }

  static Future<void> notificationResponse(msg) async {
    var decodedMsg = json.decode(msg.payload!);
    print("decoded Message: $decodedMsg");
  }

  static void showNotification(RemoteMessage message) {
    const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails(
      'net.katya.notification',
      '100',
      importance: Importance.max,
      priority: Priority.high,
      color: Color(0xFFe94168)
      
    ));
    

    notificationPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: json.encode(message.data));
  }
}
