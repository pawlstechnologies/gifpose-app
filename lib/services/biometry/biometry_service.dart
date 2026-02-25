// import 'dart:developer';

// import 'package:flutter/services.dart';

// import 'package:local_auth/local_auth.dart';
// import 'package:parallex/services/database/database_service.dart';
// import 'package:parallex/utils/locator.dart';

// abstract class BiometricService {
//   Future<bool> isBiometricAvailable();
//   Future<bool> authenticateUser();
//   Future setBiometricsEnabled(bool biometricsEnabled);
//   bool? getBiometricsEnabled();
//   Future<bool> validateImplementBiometric();
//   Future<BiometricType?> getAuthenticationType();
// }

// class BiometricServiceImpl extends BiometricService {
//   final LocalAuthentication _localAuthentication = LocalAuthentication();
//   final DatabaseService _databaseService = serviceLocator<DatabaseService>();

//   @override
//   Future<bool> isBiometricAvailable() async {
//     return await _localAuthentication.canCheckBiometrics;
//   }

//   @override
//   Future<bool> authenticateUser() async {
//     bool bioAvailable = await isBiometricAvailable();
//     if (bioAvailable) {
//       bool isAuthenticated = false;

//       try {
//         isAuthenticated = await _localAuthentication.authenticate(
//             localizedReason: "Please authenticate to proceed");
//       } on PlatformException catch (e) {
//         log(e.toString());
//       }

//       return isAuthenticated;
//     } else {
//       return false;
//     }
//   }

  

//   @override
//   bool? getBiometricsEnabled() {
//     bool? enabled = _databaseService.getbiometricEnabled();
//     //for testing
//     return enabled;
//   }

//   @override
//   setBiometricsEnabled(bool biometricsEnabled) {
//     return _databaseService.saveBiometricEnable(biometricsEnabled);
//   }

//   @override
//   Future<bool> validateImplementBiometric() async {
//     return (getBiometricsEnabled() ?? false) && await isBiometricAvailable();
//   }

//   @override
//   Future<BiometricType?> getAuthenticationType() async {
//     if (await validateImplementBiometric()) {
//       final List<BiometricType> availableBiometrics =
//           await _localAuthentication.getAvailableBiometrics();

//       if (availableBiometrics.contains(BiometricType.strong) ||
//           availableBiometrics.contains(BiometricType.face)) {
//         return BiometricType.face;
//       } else if (availableBiometrics.contains(BiometricType.weak) ||
//           availableBiometrics.contains(BiometricType.fingerprint)) {
//         return BiometricType.fingerprint;
//       } else {
//         return null;
//       }
//     }
//     return null;
//   }
// }
