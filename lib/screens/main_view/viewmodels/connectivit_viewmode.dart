import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/utils/providers/internet_connectivity.dart';



class ConnectivityProvider extends ChangeNotifier {
  final InternetConnectivity connectivity = InternetConnectivity.instance;
  bool? isOffline;
  ConnectivityProvider(BuildContext context) {
    connectivity.initialise();
    connectivity.networkChangesStream.listen((Map<ConnectivityResult, bool> source) {
      var result = source.keys.toList()[0];
      var isOnline = source[result] ?? false;

      if (isOnline) {
        backOnlineSheet(result);
      } else {
        if (isOffline == null || isOffline == false) {
          isOffline = true;
          notifyListeners();
          // UtilProvider.showAppBottomSheet(
          //   context: navigatorKey.currentContext!,
          //   builder: (p0) => const NetworkUnavailableSheet(),
          // );
          Future.delayed(const Duration(seconds: 2)).then((value) {
            // navigatorKey.currentState!.pop();
          });
        }
      }
    });
  }

  void backOnlineSheet(final ConnectivityResult result) {
    if (isOffline != null && isOffline == true) {
      isOffline = false;
      notifyListeners();
      // UtilProvider.showAppBottomSheet(
      //   context: navigatorKey.currentContext!,
      //   builder: (p0) => const NetworkAvailableSheet(),
      // );
      Future.delayed(const Duration(seconds: 2)).then((value) {
        // navigatorKey.currentState!.pop();
      });
    }
  }
}