import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:orderskatya/pages/selected_order_page/selected_order_page.dart';
import 'package:orderskatya/services/navigation_service.dart';
import 'package:orderskatya/web_api/connections/orders_connection.dart';
import 'package:orderskatya/web_api/dto/orders.dart';

import 'local_notification_service.dart';

Future<void> backgroundMessageHandler(RemoteMessage message) async {
  //THIS WORK FOR BACKGROUND MESSAGE RECEIVED (NOT CLICK)
}
class FirebaseMessagingService {
  static FirebaseMessaging? firebaseMessaging;

  static void initalization() async {
    firebaseMessaging = FirebaseMessaging.instance;
    final OrdersConnection ordersConnection = GetIt.I<OrdersConnection>();

    firebaseMessaging!.subscribeToTopic("fcm");
    await firebaseMessaging!
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

    FirebaseMessaging.onBackgroundMessage(backgroundMessageHandler);
  }
}
