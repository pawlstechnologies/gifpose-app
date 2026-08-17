

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

abstract class MainViewRepo {
  Future<SubscriptionListResponse> getSubscriptionList({
    required String deviceId,
    String? userId,
  });

  Future<CurrentSubscriptionResponse> getCurrentSubscription({
    required String deviceId,
    String? userId,
  });

 
   Future<CreateAlertListResponse> createNotificationAlerts({
    required CreateAlertListRequest createAlertListRequest,
  });

 Future<FetchItemsNearMeResponse> fetchItemsNearme({  required String deviceID, required String page,});
  Future<FetchItemsbyIdResponse> fetchItemsById({ required String deviceID,
      required String id,});
  Future<FetchUserByDeviceId> fetchUserById({ required String deviceID,
  });


        Future<AlertListCategoryResponse> fetchAlertCategories();
               Future<GetReportListResponse> getReportList();

  Future<AlertListSubCategoryResponse> fetchAlertSubCategories({ required String categoryId,});

 Future<SearchCategoryPredictionResponse> searchAlertPredictions({
    required SearchCategoryPredictionRequest  searchCategoryPredictionRequest,
  }); 
   Future<HideItemResponse> hideItem({
    required HideItemRequest  hideItemRequest,  required String id,
  });
  
     Future<ReportListingResponse> reportListing({
    required ReportListingRequest  reportListingRequest,  required String id,
  });
     Future<HideItemResponse> markItemTaken({
    required HideItemRequest  hideItemRequest, required String deviceID, required String id,
  });
  Future<SearchResponse> globalSearch({
    required String deviceId,
    required SearchCategoryPredictionRequest  searchCategoryPredictionRequest,
  });
   Future<FetchAlertListResponse> fetchAlertList({  required String deviceID,});
   Future<NotificationResponse> fetchNotification({  required String deviceID,});

  Future<CreatePaymentIntentResponse> createPaymentIntent({
    required CreatePaymentIntentRequest  createPaymentIntentRequest,
  });
 Future<CreateAlertListResponse> createAlertList({
    required CreateAlertListRequest  createAlertListRequest,
  });
  Future<CancelSubscriptionResponse> cancelSubscription({
    required CancelSubscriptionRequest cancelSubscriptionRequest,
  });
  Future<UpdateSubscriptionStatusResponse> updateSubscriptionStatus({
    required UpdateSubscriptionStatusRequest updateSubscriptionStatusRequest,
  });
}