import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:dio/dio.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/register_location_request.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/repo/onboarding_repo.dart';
import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/utils/constants/api_routes.dart';


class OnboardingRepoImpl implements OnboardingRepo {



    final NetworkProvider networkProvider = NetworkProvider();

  @override
  Future<RegisterLocationResponse> registerLocation({
    required RegisterLocationRequest registerLocationRequest,
  })
 async {
    try {
      final payload = jsonEncode(registerLocationRequest.toJson());
      log('Register location: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.registerLocation,
        method: RequestMethod.post,
        body: payload,
      );
      log("Register location reponse: ${response?.data}");
     return RegisterLocationResponse.fromJson(response?.data);
      } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }



 }
