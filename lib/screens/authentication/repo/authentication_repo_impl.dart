import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
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
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/utils/constants/api_routes.dart';


class AuthenticationRepoImpl implements AuthenticationRepo {



    final NetworkProvider networkProvider = NetworkProvider();

  @override
  Future<CreateAccountResponse> createAccount({
    required CreateAccountRequest createAccountRequest,
  })
 async {
    try {
      final payload = jsonEncode(createAccountRequest.toJson());
      log('Create account: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.register,
        method: RequestMethod.post,
        body: payload,
      );
      log("Create account response: ${response?.data}");
     return CreateAccountResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw errorMessage;
    } catch (err) {
      if (kDebugMode) print(err);
      throw "An unexpected error occurred.";
    }
  }




 

  @override
  Future<SignInResponse> signin({ required SignInRequest signinRequest})
   async {
    try {
      final payload = jsonEncode(signinRequest.toJson());
      log('Sign in: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.login,
        method: RequestMethod.post,
        body: payload,
      );
      log("Sign in response: ${response?.data}");
     return SignInResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw Exception(errorMessage);
    } catch (err) {
      if (kDebugMode) print(err);
      throw Exception(err.toString());
    }
  }

  Future<ResetPasswordResponse> resetPassword({ required ResetPasswordRequest resetPasswordRequest}) async {
    try {
      final payload = jsonEncode(resetPasswordRequest.toJson());
      log('Reset password: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.resetPassword,
        method: RequestMethod.post,
        body: payload,
      );
      log("Reset password response: ${response?.data}");
     return ResetPasswordResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw errorMessage;
    } catch (err) {
      if (kDebugMode) print(err);
      throw "An unexpected error occurred.";
    }
  }
    
Future<ForgotPasswordResponse> forgotPassword({ required ForgotPasswordRequest forgotPasswordRequest}) 
async {
    try {
      final payload = jsonEncode(forgotPasswordRequest.toJson());
      log('Forgot password: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.forgotPassword,
        method: RequestMethod.post,
        body: payload,
      );
      log("Forgot password response: ${response?.data}");
     return ForgotPasswordResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw errorMessage;
    } catch (err) {
      if (kDebugMode) print(err);
      throw "An unexpected error occurred.";
    }
  }

Future<VerifyEmailAddressResponse>   verifyEmailAddress({ required VerifyEmailAddressRequest verifyEmailAddressRequest})async {
    try {
      final payload = jsonEncode(verifyEmailAddressRequest.toJson());
      log('Verify email address: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.verifyEmail,
        method: RequestMethod.post,
        body: payload,
      );
      log("Verify email address response: ${response?.data}");
     return VerifyEmailAddressResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw errorMessage;
    } catch (err) {
      if (kDebugMode) print(err);
      throw "An unexpected error occurred.";
    }
  }
    

    Future<ResendOtpResponse> resendOtp({ required ResendOtpRequest resendOtpRequest})async {
    try {
      final payload = jsonEncode(resendOtpRequest.toJson());
      log('Resend otp: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.resendCode,
        method: RequestMethod.post,
        body: payload,
      );
      log("Resend otp response: ${response?.data}");
     return ResendOtpResponse.fromJson(response?.data);
      } on DioException catch (err) {
      log("API error response: ${err.response?.data}");
      String? errorMessage;
      if (err.response?.data is Map) {
        errorMessage = err.response?.data["message"];
      } else if (err.response?.data is String) {
        try {
          final decoded = jsonDecode(err.response!.data);
          errorMessage = decoded["message"];
        } catch (_) {}
      }
      errorMessage ??= ApiError.fromDio(err).errorDescription ?? "Something went wrong";
      
      if (kDebugMode) print(errorMessage);
      throw errorMessage;
    } catch (err) {
      if (kDebugMode) print(err);
      throw "An unexpected error occurred.";
    }
  }


 }
