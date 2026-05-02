// To parse this JSON data, do
//
//     final createPaymentIntentRequest = createPaymentIntentRequestFromJson(jsonString);

import 'dart:convert';

CreatePaymentIntentRequest createPaymentIntentRequestFromJson(String str) => CreatePaymentIntentRequest.fromJson(json.decode(str));

String createPaymentIntentRequestToJson(CreatePaymentIntentRequest data) => json.encode(data.toJson());

class CreatePaymentIntentRequest {
    String deviceId;

    CreatePaymentIntentRequest({
        required this.deviceId,
    });

    factory CreatePaymentIntentRequest.fromJson(Map<String, dynamic> json) => CreatePaymentIntentRequest(
        deviceId: json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
    };
}
