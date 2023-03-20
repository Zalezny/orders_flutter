import 'package:firebase_messaging/firebase_messaging.dart';

import 'local_notification_service.dart';

class FirebaseMessagingService {
  static void initalization(Future<void> Function(RemoteMessage) handler) async {
    FirebaseMessaging.instance.subscribeToTopic("fcm");
    await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true, 
    badge: true,
    sound: true,
  );
  LocalNotificationsService.initialize();
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage event) {
      print("Test ${event.notification}");
      LocalNotificationsService.showNotification(event);
    },
  );
  FirebaseMessaging.onMessageOpenedApp.listen(
    (RemoteMessage message) {
      if(message.data.isNotEmpty) {
        print(message.data);
      }
    },
  );

  FirebaseMessaging.onBackgroundMessage(handler);
  }
}