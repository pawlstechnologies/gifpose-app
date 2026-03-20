import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> initialize() async {
    // 1. Define the Android Channel
    const AndroidNotificationChannel channel = AndroidNotificationChannel(
      'GiftPose', 
      'GiftPose Notifications',
      description: 'General notifications for GiftPose',
      importance: Importance.max,
      playSound: true,
    );

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    
    const DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings();

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    // 2. Create the channel on the device
    await _notificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    // 3. Initialize the plugin
    await _notificationsPlugin.initialize(
      settings: initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse response) async {
        final String? payload = response.payload;
        if (payload != null) {
          debugPrint('Notification payload: $payload');
        }
      },
    );
  }

  static void displayNotification(RemoteMessage message) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      NotificationDetails notificationDetails = const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            "GiftPose", // Must match the ID in initialize()
            "GiftPose channel",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            icon: "@mipmap/ic_launcher",
          ));

      // FIXED: Using named parameters correctly
      await _notificationsPlugin.show(
        id: id,
        title: message.notification?.title ?? "No Title",
        body: message.notification?.body ?? "No Body",
        notificationDetails: notificationDetails,
        payload: message.data['id']?.toString(), 
      );
    } catch (e) {
      debugPrint("Error displaying notification: $e");
    }
  }
}