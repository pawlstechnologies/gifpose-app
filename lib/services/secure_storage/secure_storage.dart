import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

abstract class SecureStorageService {
  Future<void> write({
    required String key,
    required String? value,
  });

  Future<String?>? read({
    required String key,
  });

  Future<void> delete({
    required String key,
  });

  Future<bool> containsKey({
    required String key,
  });
}

class SecureStorageServiceImpl extends SecureStorageService {
  final _storage = const FlutterSecureStorage();

  @override
  Future<void> delete({required String key}) async {
    return await _storage.delete(key: key);
  }

  @override
  Future<String?>? read({required String key}) async {
    try {
      final value = await _storage.read(key: key);
      return value;
    } on PlatformException catch (e) {
      await _storage.delete(key: key);
      log(e.toString());
    }
    return null;
  }

  @override
  Future<void> write({required String key, required String? value}) async {
    return await _storage.write(key: key, value: value);
  }

  @override
  Future<bool> containsKey({required String key}) async {
    return await _storage.containsKey(key: key);
  }
}
