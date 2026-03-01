import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;


import 'dart:async';

import 'package:client_information/client_information.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/theme/giftpose_theme.dart';
import 'package:giftpose/utils/theme_tpye.dart';
import 'package:location/location.dart';

import 'package:web_socket_channel/web_socket_channel.dart';



class BaseViewmodel extends ChangeNotifier {

  late WebSocketChannel _channel;
  final StreamController<Map<String, dynamic>> _messageController =
      StreamController<Map<String, dynamic>>.broadcast();




 List<String> _cart = [];
 List<String> get cart => _cart;

  int _count = 1;
  int get count => _count;

  set count(int value) {
    _count = value;
    notifyListeners();
  }

  String _dailcode = "";
  String get dailcode => _dailcode; 

  set dailcode(String value) {
    _dailcode = value;
    notifyListeners();
  }

set cart(List<String> value) {
  _cart = value;

  notifyListeners();
}


  double? _latitude = 0;
  double? get latitude => _latitude;

  set latitude(double? value) {
    _latitude = value;
  }

  double? _longitude = 0;
  double? get longitude => _longitude;
  set longitude(double? value) {
    _longitude = value;
  }
  //  final List<Cart> carts = [
  //   Cart(icon: Assets.images.products1, name: 'Apple iPhone 16 Pro Max, 256GB', price: "₦1,400,000", status: "Delivered", payment: "5th payment", quantity: 1),
  //   Cart(icon: Assets.images.products2, name: 'Apple iPad Pro 11-inch (M4) Magic Keyboard', price: "₦700,000", status: "Delivered", payment: "4th payment", quantity: 3),
  //   Cart(icon: Assets.images.product3, name: 'Apple iPad Pro 11-inch (M4) Magic Keyboard', price: "₦10,000,000", status: "Due in 5 months", payment: "1st payment", quantity: 2),
  //   Cart(icon: Assets.images.products4, name: 'Samsung Galaxy S23', price: "₦900,000", status: "Due in 5Weeks", payment: "2nd payment", quantity: 4),
  //   Cart(icon: Assets.images.products6, name: 'Sound Systems', price: "₦1,000,000", status: "Due in 3Weeks", payment: "1st payment", quantity: 1),
  //   Cart(icon: Assets.images.products1, name: 'Fridges ', price: "₦1,200,000", status: "Due in 2Weeks", payment: "2nd payment", quantity: 1),
  // ];

  //  List<Products> _cartProducts = [];
  // List<Products> get cartProducts => _cartProducts;
  // set cartProducts(List<Products> value) {
  //   _cartProducts = value;
  //   notifyListeners();
  // }

  // Future<void> addToCart(List<Products> value) async {
  //   _cartProducts.addAll(value);
  //   await _databaseService.saveCart(_cartProducts);
  //   notifyListeners();
  // }
  // Future<List<Products>?> getCart() async {
  //   _cartProducts = await _databaseService.getCart() ?? [];
  //   notifyListeners();
  //   return _cartProducts;
  // }
  // Future<void> removeFromCart(String productId) async {
  //   _cartProducts.removeWhere((product) => product.id == productId);
  //   await _databaseService.deleteFromCart(productId);
  //   notifyListeners();
  // }





  void _updateConnectionStatus(ConnectivityResult connectivityResult) {
    if (connectivityResult == ConnectivityResult.none) {
      rootScaffoldMessengerKey.currentState?.showSnackBar(const SnackBar(
        content: Row(
          children: [
            Icon(
              Icons.wifi_off,
              color: Colors.white,
              size: 35,
            ),
            SizedBox(
              width: 30,
            ),
            Text('PLEASE CONNECT TO THE INTERNET')
          ],
        ),
        backgroundColor: Colors.red,
        duration: Duration(days: 1),
      ));
    } else {
      rootScaffoldMessengerKey.currentState?.hideCurrentSnackBar();
      notifyListeners();
    }
  }

   GiftPoseThemeMode? _qostThemeMode;

  GiftPoseThemeMode? get qostThemeMode => _qostThemeMode;

  set qostThemeMode(GiftPoseThemeMode? value) {
    _qostThemeMode = value;
    notifyListeners();
  }
  final DatabaseService _databaseService = serviceLocator<DatabaseService>();

    Future<void> loadTheCurrentDisplayMode() async {
    String displayModeSaved = _databaseService.getTheDisplayMode();
    switch (displayModeSaved) {
      case 'light':
        _qostThemeMode = GiftPoseThemeMode.light;
        break;


      case 'dark':
        _qostThemeMode =GiftPoseThemeMode.dark;
        break;
      default:
        _qostThemeMode = GiftPoseThemeMode.dark;
    }
    notifyListeners();
  }

  // SvgGenImage returnTheSvgBasedOnThemeModeTwo({
  //   required SvgGenImage lightMode,
  //   required SvgGenImage nightMode,
  //   required SvgGenImage darkMode,
  // }) {
  //   switch (QostThemeMode) {
  //     case ParallexThemeMode.light:
  //       return lightMode;
  //     case ParallexThemeMode.night:
  //       return nightMode;
  //     case ParallexThemeMode.dark:
  //       return darkMode;
  //     default:
  //       return lightMode;
  //   }
  // }


  int currentPageIndex = 0;
  BaseViewmodel() {
    // getLocation();
    // getDeviceId();
    // checkIfFoldable();
    // getUserAgent();
    // useragent()
    // ;
  // getCart();
  //   currentPageIndex = 0;
  // }
    String? firstname;
  String? userName;
  // Future<void> useragent() async {
  //   String userAgent = await getUserAgent();
  // }

  // String userAgent = "";
  // Future<String> getUserAgent() async {
  //   userAgent = 'ParallexMobileApp/${StorageKeys.appversion} '
  //       '(${Platform.operatingSystem} ${Platform.operatingSystemVersion})';
  //   print("userAgent$userAgent");

  //     firstname = (await secureStorageService.read(key: StorageKeys.firstName));
  //   userName = (await secureStorageService.read(key: StorageKeys.userName));
  //   return userAgent;
  // }

  // Future<void> send({required String username}) async {
  //   final message = {
  //     "channelId": "0",
  //     "username": username,
  //   };
  //   sendMessage(message);
  // }

  

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning,';
    }
    if (hour < 17) {
      return 'Afternoon,';
    }
    return 'Evening,';
  }




// will refactor to navigation class
  // bool isFoldableDevice = false;
  // Future<void> checkIfFoldable() async {
  //   DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   bool isFoldable = false;

  //   if (Platform.isAndroid) {
  //     AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  //     // Check if the device is in the list of known foldable models
  //     List<String> foldableDevices = [
  //       'SM-F900', // Galaxy Fold
  //       'SM-F916', // Galaxy Z Fold 2
  //       'SM-F926', // Galaxy Z Fold 3
  //       'SM-F936', // Galaxy Z Fold 4
  //       'SM-F946', // Galaxy Z Fold 5
  //       'SM-F700', // Galaxy Z Flip
  //       'SM-F711', // Galaxy Z Flip 3
  //       'SM-F721', // Galaxy Z Flip 4
  //       'SM-F731', // Galaxy Z Flip 5
  //     ];

  //     isFoldable =
  //         foldableDevices.any((device) => androidInfo.model.contains(device));
  //     print(androidInfo.model);
  //   } else if (Platform.isIOS) {
  //     // No foldable devices for iOS currently
  //     isFoldable = false;
  //   }

  //   isFoldableDevice = isFoldable;
  //   print("isFoldableDevice$isFoldableDevice");
  // }

 
  String androidDevicePlatform = "Android";
  String iosDevicePlatform = "iOS";
  String? deviceModel;
  String? deviceVersion;
  String? deviceId;
  String? deviceManufacturer;
  String? imel;

// fetch device details
  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late IosDeviceInfo iosInfo;
    ClientInformation info = await ClientInformation.fetch();
    print("deviceNAme${info.deviceName}");

    late AndroidDeviceInfo androidInfo;
    if (Platform.isAndroid) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = "214356743";

      // });
      print(imel);

      // imel = "21345t5y65";
      deviceId = info.deviceId;
      print("deviceID: $deviceId");

      androidInfo = await deviceInfo.androidInfo;
      deviceModel = androidInfo.model;
     
 
      String androidID = androidInfo.id;
      deviceVersion = androidInfo.version.baseOS;

      deviceManufacturer = androidInfo.manufacturer;
    } else if (Platform.isIOS) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = value;
      // });
      iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor;
      deviceModel = iosInfo.model;
      deviceVersion = iosInfo.systemVersion;

      deviceManufacturer = "Apple";
    }
  }

  String? selectedNetworkProvider;
  // biometrics


  final DatabaseService _databaseService = serviceLocator<DatabaseService>();





  Future<void> changeTheDisplayMode(String displayModeSaved) async {
    _databaseService.saveTheDisplayMode(displayModeSaved);
    switch (displayModeSaved) {
      case 'light':
        _qostThemeMode = GiftPoseThemeMode.light;
        break;
      case 'dark':
        _qostThemeMode =GiftPoseThemeMode.dark;
        break;
      default:
    }
    notifyListeners();
  }


  void changeCurrentPageIndex(int destinationIndex) {
    currentPageIndex = 0;
    currentPageIndex = destinationIndex;
    notifyListeners();
  }

  //fetch user location
  Future<void> getLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    latitude = locationData.latitude;
    longitude = locationData.longitude;
  }



  

 


  }}