import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:giftpose/app.dart';


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
    _notificationsPlugin.initialize(
      settings:initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationResponse) async {
      final String? payload = notificationResponse.payload;
      if (notificationResponse.payload != null) {
        debugPrint('notification payload: $payload');
      }


      if (navigatorKey.currentContext != null) {
        // await Navigator.push(navigatorKey.currentContext!, MaterialPageRoute(builder: (context)=> const OnboardingScreen()));
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
            "GiftPose",
            "GiftPose channel",
            channelDescription: "This is GiftPose channel for notification",
            importance: Importance.max,
            priority: Priority.high,
            playSound: true,
            enableVibration: true,
            icon: "@mipmap/ic_launcher",
            largeIcon: DrawableResourceAndroidBitmap("@mipmap/ic_launcher")
          )
      );
      await _notificationsPlugin.show(

     
              notificationDetails:  notificationDetails,
          payload: message.data['id'], id: id, title:      message.notification!.title!, body:message.notification!.body!
   , 
      );
    }on Exception catch (e){
      print(e);
    }

  }
}

