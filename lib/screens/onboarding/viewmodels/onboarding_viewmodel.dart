import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/network_data_response.dart';
import 'package:giftpose/utils/router/app_routes.dart' show AppRoutes;
import 'package:giftpose/utils/widgets/giftpose_toast.dart';
import 'package:giftpose/utils/widgets/loader_page.dart';

class OnboardingViewModel extends BaseViewmodel {
  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final TextEditingController firstNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController countryCtrl = TextEditingController();
  final TextEditingController countryCodeCtrl = TextEditingController(
    text: "+234",
  );
  final TextEditingController phoneCtrl = TextEditingController();
  final TextEditingController cityCtrl = TextEditingController();
  String verificationId = "";

  // // Check if user has valid token on app startup
  // Future<bool> checkTokenAndLoginStatus() async {
  //   try {
  //     // Check if user was previously logged in
  //     final isLoggedIn = databaseService.getIsUserLoggedIn() ?? false;

  //     if (!isLoggedIn) {
  //       return false;
  //     }

  //     // Check if token exists in secure storage
  //     final token = await secureStorageService.read(
  //       key: StorageKeys.accessToken,
  //     );

  //     if (token == null || token.isEmpty) {
  //       // Token doesn't exist, mark as logged out
  //       await databaseService.saveIsUserLoggedIn(false);
  //       return false;
  //     }

  //     // Token exists and user was logged in, assume valid session
  //     // You can add additional token validation here if needed
  //     return true;
  //   } catch (e) {
  //     // Error occurred, mark as logged out for safety
  //     await databaseService.saveIsUserLoggedIn(false);
  //     return false;
  //   }
  // }

  @override
  void dispose() {
    emailCtrl.dispose();
    otpCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void clearTextControllers() {
    passwordCtrl.clear();
    firstNameCtrl.clear();
    lastNameCtrl.clear();
    countryCtrl.clear();
    phoneCtrl.clear();
    cityCtrl.clear();

    notifyListeners();
  }

  // final SecureStorageService secureStorageService =
  //     serviceLocator<SecureStorageService>();
  // final DatabaseService databaseService = serviceLocator<DatabaseService>();
  OnboardingRepo onboardingRepo = serviceLocator<OnboardingRepo>();

  int _miles = 0;
  int get miles => _miles;

  set miles(int value) {
    _miles = value;
    notifyListeners();
  }

  NetworkDataResponse<RegisterLocationResponse> _registerLocationResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<RegisterLocationResponse> get registerLocationResponse =>
      _registerLocationResponse;

  set registerLocationResponse(
    NetworkDataResponse<RegisterLocationResponse> value,
  ) {
    _registerLocationResponse = value;
    notifyListeners();

    Future<void> registerLocation({
      required BuildContext context,
      required String postcode,
    }) async {
      try {
        registerLocationResponse = NetworkDataResponse.loading("");
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const LoaderPage()),
        );

        final response = await onboardingRepo.registerLocation(
          registerLocationRequest: RegisterLocationRequest(
            postcode: postcode,
            deviceId: deviceId ?? "",
            miles: miles,
          ),
        );

        registerLocationResponse = NetworkDataResponse.completed(response);

        Navigator.pop(context);

        if (registerLocationResponse.status == true) {
          Navigator.pushNamed(context, AppRoutes.dashboard);
        } else {
          final errorMessage = registerLocationResponse.message;
          CustomToast.show(context: context, message: errorMessage);
        }
      } catch (e) {
        registerLocationResponse = NetworkDataResponse.error(e.toString());

        CustomToast.show(context: context, message: e.toString());
      }
    }
  }
}
