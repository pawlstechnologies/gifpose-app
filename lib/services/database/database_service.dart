
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';



class DatabaseService {
  // final EncryptionService _encryptionService = 
  //     serviceLocator<EncryptionService>();
  Future initializeDb() async {
    await Hive.initFlutter();
    // Hive.registerAdapter(AuthResponseModelAdapter());


  await boxes();


   
  }

Future boxes() async {
  await Hive.openBox<String>(StorageKeys.isBiometricEmergencyReset);
    await Hive.openBox<String>(StorageKeys.displayMode);
    await Hive.openBox<bool>(StorageKeys.biometricEnabled);
    await Hive.openBox<String>(StorageKeys.cart);
    await Hive.openBox<bool>(StorageKeys.isLoggedIn);

       
 
   
   
    
    // await Hive.openBox<bool>(StorageKeys.togglePin);
}

  Future clearDB() async {
    // Box<AuthResponseModel> authResponseModel =
    //     Hive.box(StorageKeys.authResponseModel);
    // Box<EncryptedPassword> encryptedPasswordBox =
    //     Hive.box(StorageKeys.togglePin);
    Box<bool> togglePin = Hive.box(StorageKeys.togglePin);

    Box<bool> hasViewedOnboardingBox =
        Hive.box(StorageKeys.hasViewedOnboarding);
    Box<bool> biometricEnabledBox = Hive.box(StorageKeys.biometricEnabled);
    Box<String> cartBox = Hive.box(StorageKeys.cart);
        
    // authResponseModel.clear();

    togglePin.clear();
    hasViewedOnboardingBox.clear();
    biometricEnabledBox.clear();
  }

  Future saveFirstName(String value) async {
    var box = await Hive.box<String>(StorageKeys.firstName);
    box.put(StorageKeys.firstName, value);
  }

  Future<String?> getFirstName() async {
    var box = await Hive.box<String>(StorageKeys.firstName);
    var value = box.get(StorageKeys.firstName);
    print('Value from box: $value');
    return null;
  }

 String getTheDisplayMode() {
    Box<String> displayModeBox = Hive.box(StorageKeys.displayMode);

    return displayModeBox.values.isNotEmpty
        ? displayModeBox.values.first
        : MediaQuery.of(navigatorKey.currentContext!).platformBrightness ==
                Brightness.light
            ? 'light'
            : 'dark';
  }

  Future saveTheDisplayMode(String value) async {
    Box<String> displayMode = Hive.box(StorageKeys.displayMode);

    try {
      await displayMode.clear();
      displayMode.add(value);
    } catch (e) {
      log(e.toString());
    }
  }
   bool? getbiometricEnabled() {
    Box<bool> biometricEnabledBox = Hive.box(StorageKeys.biometricEnabled);
    return biometricEnabledBox.values.isNotEmpty
        ? biometricEnabledBox.values.first
        : null;
  }
    Future saveBiometricEnable(bool value) async {
    Box<bool> togglePinBox = Hive.box(StorageKeys.biometricEnabled);

    try {
      await togglePinBox.clear();
      togglePinBox.add(value);
    } catch (e) {
      if (kDebugMode) {
      log(e.toString());
    }
    }
  }
  bool? getIsUserLoggedIn() {
    Box<bool> isUserLoggedInBox = Hive.box(StorageKeys.isLoggedIn);
    return isUserLoggedInBox.values.isNotEmpty
        ? isUserLoggedInBox.values.first
        : null;
  }
    Future saveIsUserLoggedIn(bool value) async {
    Box<bool> isUserLoggedInBox = Hive.box(StorageKeys.isLoggedIn);

    try {
      await isUserLoggedInBox.clear();
      isUserLoggedInBox.add(value);
    } catch (e) {
      if (kDebugMode) {
      log(e.toString());
    }
    }
  }



  // Future saveCart(List<Products> value) async {
  //   var box = await Hive.box<String>(StorageKeys.cart);
  //   List<Map<String, dynamic>> cartJson = value.map((product) => product.toJson()).toList();
  //   box.put(StorageKeys.cart, jsonEncode(cartJson));
  // }
  // Future<List<Products>?> getCart() async {
  //   try {
  //     var box = await Hive.box<String>(StorageKeys.cart);
  //     String? cartData = box.get(StorageKeys.cart);
  //     if (cartData != null) {
  //       List<dynamic> cartJson = jsonDecode(cartData);
  //       return cartJson.map((json) => Products.fromJson(json)).toList();
  //     }
  //     return null;
  //   } catch (e) {
  //     // Clear corrupted data and return empty list
  //     await clearCartData();
  //     return [];
  //   }
  // }
  
  // Future<void> clearCartData() async {
  //   var box = await Hive.box<String>(StorageKeys.cart);
  //   await box.clear();
  // }
  // Future deleteFromCart(String productId) async {
  //   List<Products>? currentCart = await getCart();
  //   if (currentCart != null) {
  //     currentCart.removeWhere((product) => product.id == productId);
  //     await saveCart(currentCart);
  //   }
  // }
}
