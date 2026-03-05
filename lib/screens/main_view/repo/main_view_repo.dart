

import 'package:giftpose/screens/onboarding/models/alert_sub_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/alerts_category_list_response.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/search_alert_category_request.dart';
import 'package:giftpose/screens/onboarding/models/search_predictions_request.dart';


abstract class MainViewRepo {

 
   Future<CreateAlertListResponse> createNotificationAlerts({
    required CreateAlertListRequest createAlertListRequest,
  });

 Future<FetchItemsNearMeResponse> fetchItemsNearme({   required String deviceID, required String page,});
  Future<FetchItemsbyIdResponse> fetchItemsById({   required String deviceID,
      required String id,});

        Future<AlertListCategoryResponse> fetchAlertCategories();
  Future<AlertListSubCategoryResponse> fetchAlertSubCategories({  required String categoryId,});

 Future<SearchCategoryPredictionResponse> searchAlertPredictions({
    required SearchCategoryPredictionRequest  searchCategoryPredictionRequest,
  });
 

}