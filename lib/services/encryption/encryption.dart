// // ignore_for_file: always_specify_types
// import 'dart:convert';
// import 'package:encrypt/encrypt.dart';
// import 'package:flutter/services.dart';

// import 'package:pointycastle/digests/sha256.dart';

// class EncryptionService {
//   static final password = "*#PMBBlazorApp*#";

//   Uint8List generateKey(String password, Uint8List salt) {
//     final pbkdf2 = PBKDF2(
//       macAlgorithm: Hmac(SHA256Digest(), 64),
//       iterations: 1000,
//     );
//     final keyBytes = pbkdf2.process(Uint8List.fromList(utf8.encode(password)), salt);
//     return keyBytes;
//   }

//   // Encrypts the input text
//   String encrypt(String input) {
//     final salt = Uint8List.fromList(List<int>.generate(32, (index) => index));
//     final key = generateKey(password, salt);

//     final encrypter = Encrypter(
//       AES(
//         Key(Uint8List.fromList(key)),
//         IV.fromSecureRandom(16),
//         mode: AESMode.cbc,
//         padding: 'PKCS7',
//       ),
//     );

//     final encrypted = encrypter.encrypt(input);
//     final combinedIvSaltCt =
//         base64.encode(salt) + encrypted.iv.base64 + encrypted.base64;
//     return combinedIvSaltCt;
//   }

//   // Decrypts the encrypted text
//   String decrypt(String encryptedText) {
//     final combinedIvSaltCt = base64.decode(encryptedText);
//     final salt = combinedIvSaltCt.sublist(0, 32);
//     final iv = IV.fromBase64(base64.encode(combinedIvSaltCt.sublist(32, 48)));
//     final cipherText = combinedIvSaltCt.sublist(48);

//     final key = generateKey(password, Uint8List.fromList(salt));

//     final encrypter = Encrypter(
//       AES(
//         Key(Uint8List.fromList(key)),
//         iv,
//         mode: AESMode.cbc,
//         padding: 'PKCS7',
//       ),
//     );

//     final decrypted = encrypter.decrypt64(base64.encode(cipherText));
//     return decrypted;
//   }
// }
