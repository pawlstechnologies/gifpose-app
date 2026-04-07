import 'dart:developer';
import 'dart:io';

import 'package:client_information/client_information.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:giftpose/app.dart';
import 'package:giftpose/screens/authentication/models/create_account_request.dart';
import 'package:giftpose/screens/authentication/models/create_account_response.dart';
import 'package:giftpose/screens/authentication/models/forgot_password_request.dart';
import 'package:giftpose/screens/authentication/models/forgot_password_response.dart';
import 'package:giftpose/screens/authentication/models/resend_otp_request.dart';
import 'package:giftpose/screens/authentication/models/resend_otp_response.dart';
import 'package:giftpose/screens/authentication/models/reset_password_request.dart';
import 'package:giftpose/screens/authentication/models/reset_password_response.dart';
import 'package:giftpose/screens/authentication/models/sigin_request.dart';
import 'package:giftpose/screens/authentication/models/signin_response.dart';
import 'package:giftpose/screens/authentication/models/verify_email_request.dart';
import 'package:giftpose/screens/authentication/models/verify_email_response.dart';
import 'package:giftpose/screens/authentication/repo/authentication_repo.dart';
import 'package:giftpose/screens/main_view/viewmodels/base_viewmodel.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/services/database/database_service.dart';
import 'package:giftpose/services/secure_storage/secure_storage.dart'
    show SecureStorageService;
import 'package:giftpose/utils/constants/storage_keys.dart';
import 'package:giftpose/utils/locator.dart';
import 'package:giftpose/utils/network_data_response.dart';
import 'package:giftpose/utils/router/app_routes.dart' show AppRoutes;
import 'package:giftpose/utils/widgets/giftpose_toast.dart';
import 'package:giftpose/utils/widgets/loader_page.dart';

class AuthenticationViewModel extends BaseViewmodel {
  final emailCtrl = TextEditingController();
  final otpCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final TextEditingController fullNameCtrl = TextEditingController();
  final TextEditingController lastNameCtrl = TextEditingController();
  final TextEditingController usernameCtrl = TextEditingController();
  final TextEditingController confirmPasswordCtrl = TextEditingController();
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
    fullNameCtrl.dispose();
    lastNameCtrl.dispose();
    countryCodeCtrl.dispose();
    phoneCtrl.dispose();
    cityCtrl.dispose();
    super.dispose();
  }

  void clearTextControllers() {
    passwordCtrl.clear();
    fullNameCtrl.clear();
    lastNameCtrl.clear();
    countryCodeCtrl.clear();
    phoneCtrl.clear();
    cityCtrl.clear();

    notifyListeners();
  }

  AuthenticationViewModel() {
    getDeviceId();
  }


  bool _obscureText = true;
  bool get obscureText => _obscureText;
  void updateObscureText() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  bool _obscureText2 = true;
  bool get obscureText2 => _obscureText2;
  void updateObscureText2() {
    _obscureText2 = !_obscureText2;
    notifyListeners();
  }
  double _miles = 15.0;
  double get miles => _miles;
  void updateMiles(double value) {
    _miles = value;
    notifyListeners();
  }

  final SecureStorageService secureStorageService =
      serviceLocator<SecureStorageService>();
  final AuthenticationRepo authenticationRepo =
      serviceLocator<AuthenticationRepo>();

  NetworkDataResponse<CreateAccountResponse> _createAccountResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<CreateAccountResponse> get createAccountResponse =>
      _createAccountResponse;

  set createAccountResponse(NetworkDataResponse<CreateAccountResponse> value) {
    _createAccountResponse = value;
    notifyListeners();
  }

  Future<void> createAccount() async {
    try {
      createAccountResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.createAccount(
        createAccountRequest: CreateAccountRequest(
          email: emailCtrl.text,
          password: passwordCtrl.text,
          fullname: fullNameCtrl.text,
          username: usernameCtrl.text,
          confirmPassword: confirmPasswordCtrl.text,

          deviceId: deviceId ?? "",
        ),
      );


      createAccountResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (createAccountResponse.data?.status == true) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.verifyEmailScreen);
     
      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              createAccountResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
createAccountResponse = NetworkDataResponse.error(e.toString());
      final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
    }
  }


  //signin 


  NetworkDataResponse<SignInResponse> _signInResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<SignInResponse> get signInResponse =>
      _signInResponse;

  set signInResponse(NetworkDataResponse<SignInResponse> value) {
    _signInResponse = value;
    notifyListeners();
  }

  Future<void> signIn() async {
    try {
      signInResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.signin(signinRequest: SignInRequest(identifier: emailCtrl.text.trim(), password: passwordCtrl.text.trim()) );

     
      signInResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (signInResponse.data?.status == true) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.dashboard);
              secureStorageService.write(
          key: StorageKeys.accessToken,
          value: "response.data.token");
      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              signInResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
      signInResponse = NetworkDataResponse.error(e.toString());
      final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
    }
  }





//verify Email 

  NetworkDataResponse<VerifyEmailAddressResponse> _verifyEmailAddressResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<VerifyEmailAddressResponse> get verifyEmailAddressResponse =>
      _verifyEmailAddressResponse;

  set verifyEmailAddressResponse(NetworkDataResponse<VerifyEmailAddressResponse> value) {
    _verifyEmailAddressResponse = value;
    notifyListeners();

  }


  Future<void> verifyEmailAddress() async {
    try {
      verifyEmailAddressResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.verifyEmailAddress(verifyEmailAddressRequest: VerifyEmailAddressRequest(email: "ray@mailinator.com", code: otpCtrl.text.trim()));

     
      verifyEmailAddressResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (verifyEmailAddressResponse.data?.status == true) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.siginInPage);
       
      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              verifyEmailAddressResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
      verifyEmailAddressResponse = NetworkDataResponse.error(e.toString());

      final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
    }
  }


  //forgot password

  NetworkDataResponse<ForgotPasswordResponse> _forgotPasswordResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<ForgotPasswordResponse> get forgotPasswordResponse =>
      _forgotPasswordResponse;

  set forgotPasswordResponse(NetworkDataResponse<ForgotPasswordResponse> value) {
    _forgotPasswordResponse = value;
    notifyListeners();

  }

  Future<void> forgotPassword() async {
    try {
      forgotPasswordResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.forgotPassword(forgotPasswordRequest: ForgotPasswordRequest(email: emailCtrl.text.trim()));

     
      forgotPasswordResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (forgotPasswordResponse.data?.status == true) {

        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.enterOtpScreen);
       
      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              forgotPasswordResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
      forgotPasswordResponse = NetworkDataResponse.error(e.toString());

           final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
    }
  }

  //reset password

  NetworkDataResponse<ResetPasswordResponse> _resetPasswordResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<ResetPasswordResponse> get resetPasswordResponse =>
      _resetPasswordResponse;

  set resetPasswordResponse(NetworkDataResponse<ResetPasswordResponse> value) {
    _resetPasswordResponse = value;
    notifyListeners();
  }

  Future<void> resetPassword() async {
    try {
      resetPasswordResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.resetPassword(resetPasswordRequest: ResetPasswordRequest(email: emailCtrl.text.trim(), code: otpCtrl.text.trim(), newPassword: passwordCtrl.text.trim(), confirmPassword: confirmPasswordCtrl.text.trim()));

     
      resetPasswordResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (resetPasswordResponse.data?.status == true) {
        Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.passwordChanged);

      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              resetPasswordResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
      resetPasswordResponse = NetworkDataResponse.error(e.toString());

         final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
    }
  }

 //resend otp

  NetworkDataResponse<ResendOtpResponse> _resendOtpResponse =
      NetworkDataResponse.idle();

  NetworkDataResponse<ResendOtpResponse> get resendOtpResponse =>
      _resendOtpResponse;

  set resendOtpResponse(NetworkDataResponse<ResendOtpResponse> value) {
    _resendOtpResponse = value;
    notifyListeners();
  }

  Future<void> resendOtp() async {
    try {
      resendOtpResponse = NetworkDataResponse.loading("");
      LoaderPage.show(navigatorKey.currentContext!);

      final response = await authenticationRepo.resendOtp(resendOtpRequest: ResendOtpRequest(email: emailCtrl.text.trim()));

     
      resendOtpResponse = NetworkDataResponse.completed(response);

      Navigator.pop(navigatorKey.currentContext!);

      if (resendOtpResponse.data?.status == true) {

      } else {
        CustomToast.show(
          context: navigatorKey.currentContext!,
          message:
              resendOtpResponse.data?.message ?? "Something went wrong",
        );
      }
    } catch (e) {
      Navigator.pop(navigatorKey.currentContext!);
      resendOtpResponse = NetworkDataResponse.error(e.toString());

      final toastContext =
          navigatorKey.currentContext ?? navigatorKey.currentState!.context;
      CustomToast.show(context: toastContext, message: e.toString());
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
      secureStorageService.write(key: StorageKeys.deviceId, value: deviceId);

      log('deviceID: $deviceId');
    } else if (Platform.isIOS) {
      // await DeviceImei().getDeviceImei().then((value) {
      //   imel = value;
      // });
      iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor;
      secureStorageService.write(key: StorageKeys.deviceId, value: deviceId);

      log('deviceID ios : $deviceId');
    }
  }
}
