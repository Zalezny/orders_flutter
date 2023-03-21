import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/pages/selected_order_page/selected_order_page.dart';
import 'package:orderskatya/services/navigation_service.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import 'package:orderskatya/web_api/dto/orders.dart';

import 'local_notification_service.dart';

class FirebaseMessagingService {
  static void initalization(
      Future<void> Function(RemoteMessage) handler) async {
    final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();

    FirebaseMessaging.instance.subscribeToTopic("fcm");
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    LocalNotificationsService.initialize();
    FirebaseMessaging.onMessage.listen(
      (RemoteMessage message) {
        LocalNotificationsService.showNotification(message);
      },
    );
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) {
        if (message.data.isNotEmpty) {
          final String newOrderId = message.data['body'];
          ordersConnection.getOrderById(newOrderId).then(
                (order) =>
                    NavigationService.navigateToSelectedOrder(order, () {}),
              );
        }
      },
    );

    FirebaseMessaging.onBackgroundMessage(handler);
  }
}
