import 'dart:developer';
import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/services/database/database_service.dart';
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



  @override
  void dispose() {
    emailCtrl.dispose();
    otpCtrl.dispose();
    passwordCtrl.dispose();
    firstNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCtrl.dispose();
    countryCodeCtrl.dispose();
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

  OnboardingViewModel() {
    getDeviceId();
  }

  final OnboardingRepo onboardingRepo = serviceLocator<OnboardingRepo>();

  double _miles = 15.0;
  double get miles => _miles;

  set miles(double value) {
    // Ensure miles always stays within a sensible range for the slider
    _miles = value.clamp(1.0, 50.0);
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
  }
final DatabaseService databaseService = serviceLocator<DatabaseService>();
  Future<void> registerLocation({
    required BuildContext context,
    required String postcode,
  }) async {
    try {
      registerLocationResponse = NetworkDataResponse.loading("");
         await LoaderPage.show(context);


      final response = await onboardingRepo.registerLocation(
        registerLocationRequest: RegisterLocationRequest(
          postcode: postcode,
          deviceId: deviceId ?? "",
          miles: miles,
        ),
      );

      registerLocationResponse = NetworkDataResponse.completed(response);

 if (navigatorKey.currentContext!.mounted) {
      Navigator.of(navigatorKey.currentContext!, rootNavigator: true).pop(); // Dismiss dialog
    }

      if (registerLocationResponse.data?.status == true) {
        Navigator.pushNamed(context, AppRoutes.dashboard);
              await databaseService.saveIsRegistered(true);
        
      } else {
          await databaseService.saveIsRegistered(false);
        CustomToast.show(context: context, message: registerLocationResponse.data?.message ?? "Something went wrong");
      }
    } catch (e) {
      registerLocationResponse = NetworkDataResponse.error(e.toString());

      CustomToast.show(context: context, message: e.toString());
    }
  }

  String? deviceId;

  String? imel;

// fetch device details
  Future<void> getDeviceId() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late IosDeviceInfo iosInfo;
    ClientInformation info = await ClientInformation.fetch();
    log('deviceName ${info.deviceName}');
    log('deviceId ${info.deviceId}');
    late AndroidDeviceInfo androidInfo;
    if (Platform.isAndroid) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = "214356743";

      // });
      print(imel);
      androidInfo = await deviceInfo.androidInfo;
      // imel = "21345t5y65";
      deviceId = info.deviceId;
      dailcode = androidInfo.id;
      log('deviceID: $deviceId');
    } else if (Platform.isIOS) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = value;
      // });
      iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor;
      log('deviceID ios : $deviceId');
    }
  }
}
