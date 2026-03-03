

import 'package:giftpose/screens/onboarding/models/create_alerts_request.dart';
import 'package:giftpose/screens/onboarding/models/create_alerts_response.dart';
import 'package:giftpose/screens/onboarding/models/fetch_itemsnearme_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';


abstract class MainViewRepo {

 
   Future<CreateAlertListResponse> createNotificationAlerts({
    required CreateAlertListRequest createAlertListRequest,
  });

 Future<FetchItemsNearMeResponse> fetchItemsNearme({   required String deviceID, required String page,});
  Future<FetchItemsbyIdResponse> fetchItemsById({   required String deviceID,
      required String id,});

 

}