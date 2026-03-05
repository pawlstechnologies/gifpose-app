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
   await Hive.openBox<bool>(StorageKeys.isRegistered);


  }

  Future clearDB() async {
    // Box<AuthResponseModel> authResponseModel =
    //     Hive.box(StorageKeys.authResponseModel);
    // Box<EncryptedPassword> encryptedPasswordBox =
    //     Hive.box(StorageKeys.togglePin);
    Box<bool> isRegistered = Hive.box(StorageKeys.isRegistered);

    // authResponseModel.clear();

    isRegistered.clear();
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

  bool? getIsRegistered() {
    Box<bool> isRegisteredBox = Hive.box(StorageKeys.isRegistered);
    return isRegisteredBox.values.isNotEmpty
        ? isRegisteredBox.values.first
        : null;
  }

  Future saveIsRegistered(bool value) async {
    Box<bool> isRegisteredBox = Hive.box(StorageKeys.isRegistered);

    try {
      await isRegisteredBox.clear();
      isRegisteredBox.add(value);
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
