import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/firebase_options.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:provider/provider.dart';


Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  AndroidNotificationChannel androidChannel = const AndroidNotificationChannel(
    'high_importance_channel',
    'High Importance Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.max,
  );
  if (message.notification != null && Platform.isIOS) {
    await localNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidChannel);
  }
}

Future<bool> _isEmulator() async {
  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  try {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
      return androidInfo.isPhysicalDevice != true;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfoPlugin.iosInfo;
      return iosInfo.isPhysicalDevice != true;
    }
  } catch (e) {
    if (kDebugMode) {
      print('Failed to get device infoo: $e');
    }
    return false;
  }
  return false;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // Initialize FCM background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  
  // Request notification permissions
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );
  
  // // Initialize other services
   locatorSetUp();
  // final spDataBase = serviceLocator<SpDatabaseManager>();
  // await spDataBase.init();
  // LocalNotificationService.initialize();
  // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  // await serviceLocator<DatabaseService>().initializeDb();
  // SpDatabaseManager spDatabaseManager = SpDatabaseManager();
  // await SpDatabaseManager().init();
  // // if (Platform.isIOS) {
  // // }
  
  String uniqueKey = '';
  bool developerMode = false;
  DateTime now = DateTime.now();
  int timestamp = now.millisecondsSinceEpoch;
  uniqueKey = timestamp.toString();
  // await spDatabaseManager.saveTimeoutManager(manager: false);
  // SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [SystemUiOverlay.top]);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) async {
    bool jailBroken = false;
    if (Platform.isAndroid) {
//     void handleThreat(String threatDescription) {
//   print('Threat detected: $threatDescription');
//   // Optionally log, alert, or terminate the app

//   if(kReleaseMode)
//   exit(0); // Or any custom response
// }  
// final config = TalsecConfig(
//   androidConfig: AndroidConfig(
//     packageName: 'com.parallex.mobile',

// signingCertHashes: [
//   '+oiB5fEDunD6mV8SVt2uF3gSbpsd6O+aHnCuHbjiQ1o='
// ],// Replace with real SHA256 cert hash
//     supportedStores: ['google'],
//   ),
//    iosConfig: IOSConfig(
//     bundleIds: ['com.parallex.mobile'],
//     teamId: 'A67YN6UDVQ',
//   ),

//   watcherMail: 'security@parallex.com',
// );

//   await Talsec.instance.start(config);

//   final threatCallback = ThreatCallback(
//     // onAppIntegrity: () => handleThreat('App integrity compromised'),
//     onDebug: () => handleThreat('Debugger detected'),
//     onDeviceBinding: () => handleThreat('Device binding violation'),

//     onPrivilegedAccess: () => handleThreat('Privileged access detected'),
//      onADBEnabled: () => handleThreat('Adb  detected'),
//      onSystemVPN: () => handleThreat('Vpn access detected'),

//     onSimulator: () => handleThreat('Running on simulator'),
//     onSecureHardwareNotAvailable:() => handleThreat('secure hardware unavalaible'),

//   );


//   Talsec.instance.attachListener(threatCallback);






    }
    FlutterError.onError = (errorDetails) {
      // FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
    PlatformDispatcher.instance.onError = (error, stack) {
      // FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
    
    var isEmulator = await _isEmulator();

    //|| jailbroken || developerMode
    if (isEmulator && kReleaseMode) {
      exit(0);
    } else {
      runApp(
        (const GifteposeApp()),
      );
    }
  });
}

