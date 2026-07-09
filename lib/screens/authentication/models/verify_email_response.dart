// To parse this JSON data, do
//
//     final verifyEmailAddressResponse = verifyEmailAddressResponseFromJson(jsonString);

import 'dart:convert';

VerifyEmailAddressResponse verifyEmailAddressResponseFromJson(String str) => VerifyEmailAddressResponse.fromJson(json.decode(str));

String verifyEmailAddressResponseToJson(VerifyEmailAddressResponse data) => json.encode(data.toJson());

class VerifyEmailAddressResponse {
    bool status;
    String message;
    Data data;

    VerifyEmailAddressResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory VerifyEmailAddressResponse.fromJson(Map<String, dynamic> json) => VerifyEmailAddressResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
        data: Data.fromJson(json["data"] ?? json),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String message;

    Data({
        required this.message,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        message: json["message"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "message": message,
    };
}
