// To parse this JSON data, do
//
//     final createPaymentIntentResponse = createPaymentIntentResponseFromJson(jsonString);

import 'dart:convert';

CreatePaymentIntentResponse createPaymentIntentResponseFromJson(String str) => CreatePaymentIntentResponse.fromJson(json.decode(str));

String createPaymentIntentResponseToJson(CreatePaymentIntentResponse data) => json.encode(data.toJson());

class CreatePaymentIntentResponse {
    final bool success;
    final String message;
    final Data data;

    CreatePaymentIntentResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory CreatePaymentIntentResponse.fromJson(Map<String, dynamic> json) => CreatePaymentIntentResponse(
        success: json["success"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    final String subscriptionId;
    final String clientSecret;

    Data({
        required this.subscriptionId,
        required this.clientSecret,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        subscriptionId: json["subscriptionId"],
        clientSecret: json["clientSecret"],
    );

    Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "clientSecret": clientSecret,
    };
}
