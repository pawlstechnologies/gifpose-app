
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/foundation.dart';


import 'package:dio/dio.dart';
import 'package:giftpose/screens/main_view/repo/main_view_repo.dart';
import 'package:giftpose/screens/onboarding/models/alert_sub_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/alerts_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/models/search_alert_category_request.dart';
import 'package:giftpose/screens/onboarding/models/search_predictions_request.dart';

import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/utils/constants/api_routes.dart';


class MainViewRepoImpl implements MainViewRepo {



    final NetworkProvider networkProvider = NetworkProvider();

  @override

   Future<CreateAlertListResponse> createNotificationAlerts({
    required CreateAlertListRequest createAlertListRequest,
  })
 async {
    try {
      final payload = jsonEncode(createAlertListRequest.toJson());
      log('create Alert list: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.registerLocation,
        method: RequestMethod.post,
        body: payload,
      );
      log("create Alert list reponse: ${response?.data}");
     return CreateAlertListResponse.fromJson(response?.data);
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


      @override
    Future<FetchItemsNearMeResponse> fetchItemsNearme({
      required String deviceID,
      required String page,
    }) async {
    try {
      
      final response = await networkProvider.call(
        path: ApiRoutes.fetchItemsNearme.replaceAll('{deviceId}', deviceID).replaceAll('{page}', page.toLowerCase()),
        method: RequestMethod.get,
       
   
      );
      log("Fetch items near me reponse: ${response?.data}");
     return FetchItemsNearMeResponse.fromJson(response?.data);
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
 
    @override
     Future<FetchItemsbyIdResponse> fetchItemsById({
      required String deviceID,
      required String id,
     }) async {

 
    try { 
      final response = await networkProvider.call(
        path: ApiRoutes.fetchItemsbyId.replaceAll('{deviceId}', deviceID).replaceAll('{Id}', id),
        method: RequestMethod.get,
      );
      log("fetch items by id ${response?.data}");
      return FetchItemsbyIdResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    }
  }

    @override
         Future<AlertListCategoryResponse> fetchAlertCategories()async {
try { 
      final response = await networkProvider.call(
        path: ApiRoutes.alertCategoriesList,
        method: RequestMethod.get,
      );
      log("fetch alert category ${response?.data}");
      return AlertListCategoryResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    }
  }
    @override
  Future<AlertListSubCategoryResponse> fetchAlertSubCategories({  required String categoryId,}) async {


 
    try { 
      final response = await networkProvider.call(
        path: ApiRoutes.alertSubCategoriesList.replaceAll('{categoryId}', categoryId),
        method: RequestMethod.get,
      );
      log("fetch items by id ${response?.data}");
      return AlertListSubCategoryResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    }
  }

    @override
 Future<SearchCategoryPredictionResponse> searchAlertPredictions({
    required SearchCategoryPredictionRequest  searchCategoryPredictionRequest,

   })
 async {
    try {
      final payload = jsonEncode(searchCategoryPredictionRequest.toJson());
      log('search Alert category request: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.registerLocation,
        method: RequestMethod.post,
        body: payload,
      );
      log("search Alert category reponse: ${response?.data}");
     return SearchCategoryPredictionResponse.fromJson(response?.data);
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
