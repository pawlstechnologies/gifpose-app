// To parse this JSON data, do
//
//     final hideItemResponse = hideItemResponseFromJson(jsonString);

import 'dart:convert';

HideItemResponse hideItemResponseFromJson(String str) => HideItemResponse.fromJson(json.decode(str));

String hideItemResponseToJson(HideItemResponse data) => json.encode(data.toJson());

class HideItemResponse {
    bool status;
    String message;

    HideItemResponse({
        required this.status,
        required this.message,
    });

    factory HideItemResponse.fromJson(Map<String, dynamic> json) => HideItemResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
