import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/firebase_options.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/notification_services/local_notification_services.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:google_maps_flutter_android/google_maps_flutter_android.dart';
import 'package:google_maps_flutter_platform_interface/google_maps_flutter_platform_interface.dart';

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  debugPrint("Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();


  try {
 
Stripe.publishableKey = "pk_live_51TNDZZC6ikZRTwRsUGYLPX4L8DxBh3o3P8Dnk1V55CjeuXnPq2QNhwPW3Jj6HqVcXq33YHZE6sMkOxOhB6N2kbww00IB8RZWG5";
    await Stripe.instance.applySettings();
  } catch (e, s) {
    print("STRIPE INIT ERROR: $e");
    print(s);
  }
  locatorSetUp();
  await serviceLocator<DatabaseService>().initializeDb();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
final GoogleMapsFlutterPlatform mapsImplementation =
      GoogleMapsFlutterPlatform.instance;
  if (mapsImplementation is GoogleMapsFlutterAndroid) {
    
    mapsImplementation.useAndroidViewSurface = true; // Use Hybrid Composition

  }
  // Initialize Notification Service
  await LocalNotificationService.initialize();

  // Background Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

 

  // Listen for Foreground Messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    LocalNotificationService.displayNotification(message);
  });

  // Handle message when app is opened from background state via notification tap
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint("Notification clicked from background: ${message.messageId}");
  });

  // Handle message when app is opened from terminated state via notification tap
  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
    if (message != null) {
      debugPrint("Notification clicked from terminated state: ${message.messageId}");
    }
  });

  // Presentation options for iOS foreground
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: false,
    sound: true,
  );

  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then((_) {
    runApp(GifteposeApp());
  });
}