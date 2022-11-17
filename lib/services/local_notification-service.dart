import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notification_PluginTest =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings("@mipmap/ic_launcher"));
    _notification_PluginTest.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        if (details.payload != null) {
          String? route = details.payload;
          Navigator.of(context).pushNamed(route!);
        }
      },
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id = 4;
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "Test Abroach abdo", "Test Abroach abdo channel",
              playSound: true,
              priority: Priority.high,
              importance: Importance.max));
      await _notification_PluginTest.show(id, message.notification!.title,
          message.notification!.body, notificationDetails,
          payload: message.data["route"]);
    } on Exception catch (error) {
      print(error);
    }
  }
}
