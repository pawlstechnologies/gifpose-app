import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:qost/app.dart';
import 'package:qost/screens/onboarding/views/onboarding_screen.dart';

class LocalNotificationService{
  static final FlutterLocalNotificationsPlugin _notificationsPlugin = FlutterLocalNotificationsPlugin();

    static void initialize() async {
    // final SecureStorageService secureStorageService = serviceLocator<SecureStorageService>();
    // bool isRegistered = serviceLocator<DatabaseService>().getRegistrationCompleteStatus() ?? false;
    // String firstname = "";
    // firstname = (await secureStorageService.read(key: StorageKeys.firstName)) ?? "";
    AndroidInitializationSettings initializationSettingsAndroid = const AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettingsIOS = const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    _notificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        debugPrint('notification payload: $payload');
      }


      if (navigatorKey.currentContext != null) {
        await Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=> const OnboardingScreen()));
      }

    });
  }

  static void displayNotification(RemoteMessage message)async {
    try{
      final id = DateTime.now().millisecondsSinceEpoch ~/1000;

       NotificationDetails notificationDetails = const NotificationDetails(
          iOS: DarwinNotificationDetails(
            presentAlert: true,
            presentBadge: true,
            presentSound: true,
          ),
          android: AndroidNotificationDetails(
            "ParallexMobile",
            "ParallexMobile channel",
            channelDescription: "This is ParallexMobile channel for notification",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: "@mipmap/ic_launcher",
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher")
          )
      );
      await _notificationsPlugin.show(
          id,
          message.notification!.title!,
          message.notification!.body!,
          notificationDetails,
          payload: message.data['id'],
      );
    }on Exception catch (e){
      print(e);
    }

  }
}

