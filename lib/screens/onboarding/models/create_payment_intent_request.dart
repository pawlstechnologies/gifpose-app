// To parse this JSON data, do
//
//     final createPaymentIntentRequest = createPaymentIntentRequestFromJson(jsonString);

import 'dart:convert';

CreatePaymentIntentRequest createPaymentIntentRequestFromJson(String str) => CreatePaymentIntentRequest.fromJson(json.decode(str));

String createPaymentIntentRequestToJson(CreatePaymentIntentRequest data) => json.encode(data.toJson());

class CreatePaymentIntentRequest {
    final String deviceId;
    final String plan;

    CreatePaymentIntentRequest({
        required this.deviceId,
        required this.plan,
    });

    factory CreatePaymentIntentRequest.fromJson(Map<String, dynamic> json) => CreatePaymentIntentRequest(
        deviceId: json["deviceId"],
        plan: json["plan"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "plan": plan,
    };
}
