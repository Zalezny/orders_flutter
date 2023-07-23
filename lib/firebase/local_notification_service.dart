import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/services/navigation_service.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';

class LocalNotificationsService {
  static final FlutterLocalNotificationsPlugin notificationPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize() {
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings(
          'ic_logo',
        ),
        iOS: DarwinInitializationSettings(
          onDidReceiveLocalNotification: (id, title, body, payload) {},
        ));

    notificationPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: notificationResponse,
      onDidReceiveBackgroundNotificationResponse: notificationResponse,
    );
  }

  static Future<void> notificationResponse(msg) async {
    final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();
    final Map<String, dynamic> decodedMsg = await json.decode(msg.payload!);

    if (decodedMsg.isNotEmpty) {
      final String newOrderId = decodedMsg['body'];
      ordersConnection.getOrderById(newOrderId).then(
            (order) => NavigationService.navigateToSelectedOrder(order, () {}),
          );
    }
  }

  static void showNotification(RemoteMessage message) {
    const NotificationDetails notificationDetails = NotificationDetails(
        android: AndroidNotificationDetails('net.katya.notification', '100',
            importance: Importance.max,
            priority: Priority.high,
            color: Color(0xFFe94168)));

    notificationPlugin.show(
        DateTime.now().microsecond,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: json.encode(message.data));
  }
}
