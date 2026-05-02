// To parse this JSON data, do
//
//     final createPaymentIntentResponse = createPaymentIntentResponseFromJson(jsonString);

import 'dart:convert';

CreatePaymentIntentResponse createPaymentIntentResponseFromJson(String str) => CreatePaymentIntentResponse.fromJson(json.decode(str));

String createPaymentIntentResponseToJson(CreatePaymentIntentResponse data) => json.encode(data.toJson());

class CreatePaymentIntentResponse {
    bool success;
    String message;
    Data data;

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
    String clientSecret;

    Data({
        required this.clientSecret,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        clientSecret: json["clientSecret"],
    );

    Map<String, dynamic> toJson() => {
        "clientSecret": clientSecret,
    };
}
