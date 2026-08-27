
import 'dart:convert';
import 'dart:developer';
import 'dart:developer' as Debugger;

import 'package:flutter/foundation.dart';


import 'package:dio/dio.dart';
import 'package:giftpose/screens/main_view/repo/main_view_repo.dart';
import 'package:giftpose/screens/onboarding/models/alert_sub_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/alerts_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/create_payment_intent_request.dart';
import 'package:giftpose/screens/onboarding/models/create_payment_intent_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_alert_list_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_user_by_deviceid_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/get_report_listing_reponse.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_request.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_response.dart';
import 'package:giftpose/screens/onboarding/models/notification_response.dart';
import 'package:giftpose/screens/onboarding/models/register_location_response.dart';
import 'package:giftpose/screens/onboarding/models/report_listing_request.dart';
import 'package:giftpose/screens/onboarding/models/report_listing_response.dart';
import 'package:giftpose/screens/onboarding/models/search_alert_category_request.dart';
import 'package:giftpose/screens/onboarding/models/search_predictions_request.dart';
import 'package:giftpose/screens/onboarding/models/search_response.dart';

import 'package:giftpose/screens/onboarding/models/cancel_subscription_request.dart';
import 'package:giftpose/screens/onboarding/models/cancel_subscription_response.dart';
import 'package:giftpose/screens/onboarding/models/subscription_list_response.dart';
import 'package:giftpose/screens/onboarding/models/current_subscription_response.dart';
import 'package:giftpose/screens/onboarding/models/update_subscription_status_request.dart';
import 'package:giftpose/screens/onboarding/models/update_subscription_status_response.dart';
import 'package:giftpose/screens/onboarding/models/change_plan_request.dart';
import 'package:giftpose/screens/onboarding/models/change_plan_response.dart';
import 'package:giftpose/services/network_services/dio_core/dio_client.dart';
import 'package:giftpose/services/network_services/dio_core/dio_error.dart';
import 'package:giftpose/utils/constants/api_routes.dart';

class MainViewRepoImpl implements MainViewRepo {
  final NetworkProvider networkProvider = NetworkProvider();

  @override
  Future<SubscriptionListResponse> getSubscriptionList({
    required String deviceId,
    String? userId,
  }) async {
    try {
      String path = "${ApiRoutes.subscriptionList}?deviceId=$deviceId";
      if (userId != null && userId.isNotEmpty) {
        path += "&userId=$userId";
      }
      log("Fetching subscription list: $path");
      final response = await networkProvider.call(
        path: path,
        method: RequestMethod.get,
      );
      log("getSubscriptionList response: ${response?.data}");
      return SubscriptionListResponse.fromJson(response?.data);
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
  Future<CurrentSubscriptionResponse> getCurrentSubscription({
    required String deviceId,
    String? userId,
  }) async {
    try {
      String path = "${ApiRoutes.currentSubscription}?deviceId=$deviceId";
      if (userId != null && userId.isNotEmpty) {
        path += "&userId=$userId";
      }
      log("Fetching current subscription: $path");
      final response = await networkProvider.call(
        path: path,
        method: RequestMethod.get,
      );
      log("getCurrentSubscription response: ${response?.data}");
      return CurrentSubscriptionResponse.fromJson(response?.data);
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

   Future<CreateAlertListResponse> createNotificationAlerts({
    required CreateAlertListRequest createAlertListRequest,
  })
 async {
    try {
      final payload = jsonEncode(createAlertListRequest.toJson());
      log('create Alert list: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.createAlerts,
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
  Future<HideItemResponse> hideItem({
    required HideItemRequest  hideItemRequest,  required String id,
  }) async {
    try {
       log("Hide items requested}");
      final payload = jsonEncode(hideItemRequest.toJson());
      final response = await networkProvider.call(
        path: ApiRoutes.markItemHide.replaceAll('{Id}', id),
        method: RequestMethod.patch,
           body: payload,
   
      );
      log("Hide items reponse: ${response?.data}");


   
     return HideItemResponse.fromJson(response?.data);
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
  Future<ReportListingResponse> reportListing({
    required ReportListingRequest  reportListingRequest,  required String id,
  }) async {
    try {
          final payload = jsonEncode(reportListingRequest.toJson());
      log('create Alert list: $payload');
      

      
      final response = await networkProvider.call(
        path: ApiRoutes.reportItem
        .replaceAll('{Id}', id),
        method: RequestMethod.post,
        body: payload,
       
   
      );
      log("Hide items reponse: ${response?.data}");


   
     return ReportListingResponse.fromJson(response?.data);
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
           Future<GetReportListResponse> getReportList()async {
try { 
      final response = await networkProvider.call(
        path: ApiRoutes.getReportList,
        method: RequestMethod.get,
      );
      log("fetch report list ${response?.data}");
      return GetReportListResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final errorMessage = Future.error(ApiError.fromDio(err));
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data["message"] ?? errorMessage;
    }
  }


  @override
  Future<CreatePaymentIntentResponse> createPaymentIntent({
    required CreatePaymentIntentRequest  createPaymentIntentRequest,
  }) async {
    try {
      final payload = jsonEncode(createPaymentIntentRequest.toJson());
      log('create payment intent: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.createPaymentIntent,
        method: RequestMethod.post,
        body: payload,
      );
      log("create payment intent reponse: ${response?.data}");
    
     return CreatePaymentIntentResponse.fromJson(response?.data);
      } on DioException catch (err) {
      final apiError = ApiError.fromDio(err);
      if (kDebugMode) {
        print(apiError);
      }
      throw err.response?.data["message"] ?? apiError;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }   
  
  @override
  Future<HideItemResponse> markItemTaken({
    required HideItemRequest hideItemRequest,
    required String id,
  }) async {
    try {
      final payload = jsonEncode(hideItemRequest.toJson());
      final response = await networkProvider.call(
        path: ApiRoutes.markItemTaken.replaceAll('{Id}', id),
        method: RequestMethod.patch,
        body: payload,
      );
      log("mark items response: ${response?.data}");

      return HideItemResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final apiError = ApiError.fromDio(err);
      String errorMessage = apiError.errorDescription ?? "Something went wrong";
      if (err.response?.statusCode == null || err.response!.statusCode! < 500) {
        final responseData = err.response?.data;
        if (responseData is Map && responseData["message"] != null) {
          errorMessage = responseData["message"].toString();
        }
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      throw errorMessage;
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
     Future<FetchAlertListResponse> fetchAlertList({  required String deviceID,})async {
    try {
      
      final response = await networkProvider.call(
        path: ApiRoutes.fetchAlertLists.replaceAll('{deviceId}', deviceID),
        method: RequestMethod.get,
       
   
      );
      log("Fetch alert list: ${response?.data}");
  

   
     return FetchAlertListResponse.fromJson(response?.data);
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
   Future<FetchUserByDeviceId> fetchUserById({ required String deviceID,
  })async {

 
    try { 
      final response = await networkProvider.call(
        path: ApiRoutes.fetchUserbyDeviceID.replaceAll('{Id}', deviceID),
        method: RequestMethod.get,
      );
      log("fetch items by id ${response?.data}");
      return FetchUserByDeviceId.fromJson(response?.data);
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


     Future<NotificationResponse> fetchNotification({  required String deviceID,})
      async {


 
    try { 
      final response = await networkProvider.call(
        path: ApiRoutes.notifications.replaceAll('{deviceId}', deviceID),
        method: RequestMethod.get,
      );
      log("fetch notifications ${response?.data}");
      return NotificationResponse.fromJson(response?.data);
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
        path: ApiRoutes.searchAlertCategories ,
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
      @override
  Future<SearchResponse> globalSearch({
     required String deviceId,
    required SearchCategoryPredictionRequest  searchCategoryPredictionRequest,
  })
 async {
    try {
      final payload = jsonEncode(searchCategoryPredictionRequest.toJson());
      log('search Alert category request: $payload');
      
   
      
      final response = await networkProvider.call(
        path: ApiRoutes.globalSearch.replaceAll('{deviceId}', deviceId),
        method: RequestMethod.post,
        body: payload,
      );
      log("search Alert category reponse: ${response?.data}");
     return SearchResponse.fromJson(response?.data);
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
Future<CreateAlertListResponse> createAlertList({
  required CreateAlertListRequest createAlertListRequest,
}) async {
  try {
    final payload = jsonEncode(createAlertListRequest.toJson());
    log('create Alert list request: $payload');
    
    final response = await networkProvider.call(
      path: ApiRoutes.createAlerts, // Assuming this route exists
      method: RequestMethod.post,
      body: payload,
    );
    
    log("create Alert list response: ${response?.data}");
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
  Future<CancelSubscriptionResponse> cancelSubscription({
    required CancelSubscriptionRequest cancelSubscriptionRequest,
  }) async {
    try {
      final payload = jsonEncode(cancelSubscriptionRequest.toJson());
      log('cancel subscription payload: $payload');

      final response = await networkProvider.call(
        path: ApiRoutes.cancelSubscription,
        method: RequestMethod.post,
        body: payload,
      );
      log("cancel subscription response: ${response?.data}");

      return CancelSubscriptionResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final apiError = ApiError.fromDio(err);
      if (kDebugMode) {
        print(apiError);
      }
      throw err.response?.data["message"] ?? apiError;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<UpdateSubscriptionStatusResponse> updateSubscriptionStatus({
    required UpdateSubscriptionStatusRequest updateSubscriptionStatusRequest,
  }) async {
    try {
      final payload = jsonEncode(updateSubscriptionStatusRequest.toJson());
      log('update subscription status payload: $payload');

      final response = await networkProvider.call(
        path: ApiRoutes.updateSubscriptionStatus,
        method: RequestMethod.patch,
        body: payload,
      );
      log("update subscription status response: ${response?.data}");

      return UpdateSubscriptionStatusResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final apiError = ApiError.fromDio(err);
      if (kDebugMode) {
        print(apiError);
      }
      throw err.response?.data["message"] ?? apiError;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }

  @override
  Future<ChangePlanResponse> changePlan({
    required ChangePlanRequest changePlanRequest,
  }) async {
    try {
      final payload = jsonEncode(changePlanRequest.toJson());
      log('change plan payload: $payload');

      final response = await networkProvider.call(
        path: ApiRoutes.changePlan,
        method: RequestMethod.post,
        body: payload,
      );
      log("change plan response: ${response?.data}");

      return ChangePlanResponse.fromJson(response?.data);
    } on DioException catch (err) {
      final apiError = ApiError.fromDio(err);
      String errorMessage = apiError.errorDescription ?? "Something went wrong";
      if (err.response?.statusCode == null || err.response!.statusCode! < 500) {
        final responseData = err.response?.data;
        if (responseData is Map && responseData["message"] != null) {
          errorMessage = responseData["message"].toString();
        }
      }
      if (kDebugMode) {
        print(errorMessage);
      }
      throw err.response?.data?["message"] ?? errorMessage;
    } catch (err) {
      if (kDebugMode) {
        print(err);
      }
      throw err.toString();
    }
  }
}
