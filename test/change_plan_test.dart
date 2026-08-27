import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:giftpose/screens/onboarding/models/change_plan_request.dart';
import 'package:giftpose/screens/onboarding/models/change_plan_response.dart';
import 'package:giftpose/screens/onboarding/models/fetchitems_byid_response.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_request.dart';
import 'package:giftpose/screens/onboarding/models/hide_item_response.dart';
import 'package:giftpose/utils/constants/api_routes.dart';

void main() {
  group('Change Plan API & Models Test Suite', () {
    test('ApiRoutes contains correct changePlan endpoint', () {
      expect(ApiRoutes.changePlan, '/subscription/change-plan');
      expect('${ApiRoutes.baseUrl}${ApiRoutes.changePlan}',
          'https://api.giftpose.com/api/subscription/change-plan');
    });

    test('ChangePlanRequest serializes to expected JSON structure', () {
      final request = ChangePlanRequest(plan: 'annual');
      final jsonMap = request.toJson();

      expect(jsonMap, {'plan': 'annual'});
      expect(changePlanRequestToJson(request), '{"plan":"annual"}');

      final deserialized =
          changePlanRequestFromJson('{"plan":"monthly"}');
      expect(deserialized.plan, 'monthly');
    });

    test('ChangePlanResponse parses successful response correctly', () {
      final jsonString = '''{
        "success": true,
        "message": "Pay now for annual. Your monthly plan stays active until ... annual starts on ...",
        "data": {
          "clientSecret": "pi_3MtwxAEomAQGu0t00A6nhDwP_secret_6RhK1l81FjE10m",
          "currentPlan": "monthly",
          "newPlan": "annual",
          "currentPlanEndsAt": "2026-09-02T12:00:00.000Z",
          "newPlanStartsAt": "2026-09-02T12:00:00.000Z",
          "amount": 999,
          "currency": "gbp"
        }
      }''';

      final response = changePlanResponseFromJson(jsonString);

      expect(response.success, isTrue);
      expect(response.message,
          contains('Pay now for annual'));
      expect(response.data, isNotNull);
      expect(response.data!.clientSecret,
          'pi_3MtwxAEomAQGu0t00A6nhDwP_secret_6RhK1l81FjE10m');
      expect(response.data!.currentPlan, 'monthly');
      expect(response.data!.newPlan, 'annual');
      expect(response.data!.currentPlanEndsAt, '2026-09-02T12:00:00.000Z');
      expect(response.data!.newPlanStartsAt, '2026-09-02T12:00:00.000Z');
      expect(response.data!.amount, 999);
      expect(response.data!.currency, 'gbp');
    });

    test('ChangePlanResponse parses failure response correctly', () {
      final jsonString = '''{
        "success": false,
        "message": "No active subscription in database to change"
      }''';

      final response = changePlanResponseFromJson(jsonString);

      expect(response.success, isFalse);
      expect(response.message, 'No active subscription in database to change');
      expect(response.data, isNull);
    });

    test('ChangePlanResponse handles null and dynamic fields safely', () {
      final response = ChangePlanResponse.fromJson(null);
      expect(response.success, isNull);
      expect(response.message, isNull);
      expect(response.data, isNull);

      final responseWithAmountDouble = ChangePlanResponse.fromJson({
        "success": true,
        "message": "Plan change scheduled",
        "data": {
          "clientSecret": "pi_test",
          "amount": 9.99,
          "currency": "GBP"
        }
      });
      expect(responseWithAmountDouble.success, isTrue);
      expect(responseWithAmountDouble.data?.amount, 9.99);
      expect(responseWithAmountDouble.data?.currency, 'GBP');
    });

    test('FetchItemsbyIdResponse handles null and missing fields safely', () {
      final jsonStringWithNulls = '''{
        "success": true,
        "message": "Item details fetched successfully",
        "data": {
          "_id": "item123",
          "name": "Vintage Table",
          "description": null,
          "imageUrls": null,
          "category": null,
          "subCategory": null,
          "location": null,
          "city": null,
          "country": null,
          "pickup": null,
          "expiration": null,
          "url": null,
          "partner": null,
          "visitCount": null,
          "distanceInMeters": null,
          "distanceInMiles": null,
          "estimatedTravelTime": null,
          "createdAt": null
        }
      }''';

      final response = fetchItemsbyIdResponseFromJson(jsonStringWithNulls);

      expect(response.success, isTrue);
      expect(response.data.id, 'item123');
      expect(response.data.name, 'Vintage Table');
      expect(response.data.description, '');
      expect(response.data.imageUrls, isEmpty);
      expect(response.data.category, '');
      expect(response.data.subCategory, '');
      expect(response.data.city, '');
      expect(response.data.country, '');
      expect(response.data.pickup, isFalse);
      expect(response.data.visitCount, 0);
      expect(response.data.distanceInMiles, 0.0);
      expect(response.data.estimatedTravelTime.walking, '');
    });

    test('Mark Item Taken endpoint and request payload are correct', () {
      expect(ApiRoutes.markItemTaken, '/item/mark-taken/{Id}');
      final itemId = '69d6c42177fb878151770876';
      final path = ApiRoutes.markItemTaken.replaceAll('{Id}', itemId);
      expect(path, '/item/mark-taken/69d6c42177fb878151770876');

      final request = HideItemRequest(deviceId: 'Device_05');
      final jsonPayload = jsonEncode(request.toJson());
      expect(jsonPayload, '{"deviceId":"Device_05"}');

      final responseJson = '{"status":true,"message":"Item marked as taken successfully"}';
      final hideResponse = hideItemResponseFromJson(responseJson);
      expect(hideResponse.status, isTrue);
      expect(hideResponse.message, 'Item marked as taken successfully');
    });
  });
}
