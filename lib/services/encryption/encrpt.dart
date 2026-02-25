// import 'package:encrypt/encrypt.dart';
// import 'dart:convert';
// import 'dart:typed_data';

// class SecureStorage {
//   static final String _keyString = "mySuperDecrezboy1234567890abcdef"; // 32 bytes
//   static Key get _key => Key.fromUtf8(_keyString);

//   static String encryptData(String plainText) {
//     final iv = IV.fromSecureRandom(16); // ✅ Secure, random IV
//     final encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: "PKCS7"));
//     final encrypted = encrypter.encrypt(plainText, iv: iv);

//     final combined = iv.bytes + encrypted.bytes;
//     return base64.encode(combined);
//   }

//   static String decryptData(String encryptedText) {
//     try {
//       final bytes = base64.decode(encryptedText);
//       print("📏 Total decoded length: ${bytes.length}");

//       if (bytes.length < 32) {
//         // 16 for IV + 16 minimum for AES block
//         return "Decryption Failed: Not enough data";
//       }

//       final iv = IV(Uint8List.fromList(bytes.sublist(0, 16)));
//       final encryptedData = Encrypted(Uint8List.fromList(bytes.sublist(16)));

//       print("🔑 IV: ${base64.encode(iv.bytes)}");
//       print("🔒 Encrypted payload length: ${encryptedData.bytes.length}");

//       final encrypter = Encrypter(AES(_key, mode: AESMode.cbc, padding: "PKCS7"));
//       return encrypter.decrypt(encryptedData, iv: iv);
//     } catch (e) {
//       print("❌ Decryption Error: $e");
//       return "Decryption Failed: $e";
//     }
//   }
// }