// // ignore_for_file: deprecated_member_use

// import 'dart:convert';
// import 'dart:math';

// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_dotenv/flutter_dotenv.dart';

// import 'package:parallex/services/encryption/encrpt.dart';

// import 'package:pointycastle/export.dart';

// class EncryptionHelper {
//   static  String fstring = SecureStorage.decryptData("Zcn5TK/MDiyhpK30JOGHGXjVtFSKTMkObf4sWE1m5W9kCrhR8pS/xz+sXMgMdEIU02d/DSqWxDqWdq/IhZ80Gg==");
  
//   static const int iterations = 1000;

//   static Uint8List createKey(String password, Uint8List salt) {
//     var key =   SecureStorage.decryptData(password);
//     final pbkdf2Parameters = Pbkdf2Parameters(salt, iterations, 32);
//     final keyDerivator = PBKDF2KeyDerivator(HMac(SHA256Digest(), 64))
//       ..init(pbkdf2Parameters);

//     return keyDerivator.process(Uint8List.fromList(utf8.encode(fstring)));
//   }

//   static Uint8List getSalt() {
//     final random = Random.secure();
//     final salt = Uint8List(32);
//     for (var i = 0; i < salt.length; i++) {
//       salt[i] = random.nextInt(256);
//     }
//     return salt;
//   }

//   static Future<String> defaultEncryption(String? json) async {
//     //final key =Key(Uint8List.fromList(utf8.encode(EncryptionKeys.encryptionKey)));
//     // final iv =
//     //     IV(Uint8List.fromList(utf8.encode(EncryptionKeys.encryptionKey)));

//     //log(key.toString());

//     var salt = getSalt();
//     final key = createKey(fstring, salt);
//     final encrypter =
//         Encrypter(AES(Key(key), mode: AESMode.cbc, padding: "PKCS7"));
// // Create the IV with repeated 0 values
//     final iv = IV.fromSecureRandom(16);
//     final encrypted = encrypter.encrypt(json!, iv: iv);
//     final combinedIvSaltCt =
//         Uint8List.fromList([...salt, ...iv.bytes, ...encrypted.bytes]);
//     return base64.encode(combinedIvSaltCt);
//   }

//   static Future<String> defaultDecryption(String json) async {
//     //String? encryptionKey = EncryptionKeys.encryptionKey;
//     //String? encryptionIV = EncryptionKeys.encryptionIV;

//     var encryptedData = base64.decode(json);
//     final salt = encryptedData.sublist(0, 32);
//     final key = createKey(fstring, salt);
//     final iv = IV(encryptedData.sublist(32, 48));
//     final cipherText = encryptedData.sublist(48);

//     final encrypter =
//         Encrypter(AES(Key(key), mode: AESMode.cbc, padding: "PKCS7"));
//     var encrypted = Encrypted(cipherText);
//     final decrypted = encrypter.decrypt(encrypted, iv: iv);
 
//     print(decrypted);
//     return decrypted.trim();
//   }
// }
