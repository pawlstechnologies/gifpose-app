// To parse this JSON data, do
//
//     final createAlertListRequest = createAlertListRequestFromJson(jsonString);

import 'dart:convert';

CreateAlertListRequest createAlertListRequestFromJson(String str) => CreateAlertListRequest.fromJson(json.decode(str));

String createAlertListRequestToJson(CreateAlertListRequest data) => json.encode(data.toJson());

class CreateAlertListRequest {
    String firebaseToken;
    String deviceId;
    List<String> categories;
    List<String> keywords;
    String status;

    CreateAlertListRequest({
        required this.firebaseToken,
        required this.deviceId,
        required this.categories,
        required this.keywords,
        required this.status,
    });

    factory CreateAlertListRequest.fromJson(Map<String, dynamic> json) => CreateAlertListRequest(
        firebaseToken: json["firebaseToken"],
        deviceId: json["deviceId"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "firebaseToken": firebaseToken,
        "deviceId": deviceId,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "status": status,
    };
}
