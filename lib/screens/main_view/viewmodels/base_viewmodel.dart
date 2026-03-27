import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;


import 'dart:async';

import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:client_information/client_information.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/theme/giftpose_theme.dart';
import 'package:giftpose/utils/theme_tpye.dart';


import 'package:web_socket_channel/web_socket_channel.dart';



class BaseViewmodel extends ChangeNotifier {
  String? _fcmToken;
  String? get fcmToken => _fcmToken;

  BaseViewmodel() {
    getFcmToken();
  }

  void setFcmToken(String? token) {
    _fcmToken = token;
    notifyListeners();
  }

  Future<void> getFcmToken() async {
    try {
      // APNS logic is ONLY for iOS. Android uses FCM directly.
      if (Platform.isIOS) {
        String? apnsToken = await FirebaseMessaging.instance.getAPNSToken();
        
        int retry = 0;
        while (apnsToken == null && retry < 3) {
          debugPrint("Waiting for iOS APNS token...");
          await Future.delayed(Duration(seconds: 3));
          apnsToken = await FirebaseMessaging.instance.getAPNSToken();
          retry++;
        }
        
        if (apnsToken == null) {
          debugPrint("Failed to get APNS token. FCM might not work on this iOS device.");
          return;
        }
      }

      // Safe to get FCM token for both Android and iOS (after iOS APNS handshake)
      String? token = await FirebaseMessaging.instance.getToken();
      
      if (token != null) {
        debugPrint("FCM Token: $token");
        setFcmToken(token);
      }
    } catch (e) {
      debugPrint("❌ Error fetching FCM Token: $e");
    }
  }
}