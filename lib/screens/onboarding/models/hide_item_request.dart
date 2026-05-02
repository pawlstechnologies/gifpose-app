// To parse this JSON data, do
//
//     final hideItemRequest = hideItemRequestFromJson(jsonString);

import 'dart:convert';

HideItemRequest hideItemRequestFromJson(String str) => HideItemRequest.fromJson(json.decode(str));

String hideItemRequestToJson(HideItemRequest data) => json.encode(data.toJson());

class HideItemRequest {
    String deviceId;

    HideItemRequest({
        required this.deviceId,
    });

    factory HideItemRequest.fromJson(Map<String, dynamic> json) => HideItemRequest(
        deviceId: json["deviceId"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
    };
}
