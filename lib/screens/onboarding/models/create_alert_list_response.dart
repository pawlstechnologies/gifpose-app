// To parse this JSON data, do
//
//     final createAlertListResponse = createAlertListResponseFromJson(jsonString);

import 'dart:convert';

CreateAlertListResponse createAlertListResponseFromJson(String str) => CreateAlertListResponse.fromJson(json.decode(str));

String createAlertListResponseToJson(CreateAlertListResponse data) => json.encode(data.toJson());

class CreateAlertListResponse {
    bool success;
    Data data;

    CreateAlertListResponse({
        required this.success,
        required this.data,
    });

    factory CreateAlertListResponse.fromJson(Map<String, dynamic> json) => CreateAlertListResponse(
        success: json["success"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": data.toJson(),
    };
}

class Data {
    String id;
    String deviceId;
    int v;
    List<String> categories;
    DateTime createdAt;
    String firebaseToken;
    List<String> keywords;
    String status;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.deviceId,
        required this.v,
        required this.categories,
        required this.createdAt,
        required this.firebaseToken,
        required this.keywords,
        required this.status,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        deviceId: json["deviceId"],
        v: json["__v"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        createdAt: DateTime.parse(json["created_at"]),
        firebaseToken: json["firebaseToken"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        status: json["status"],
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "__v": v,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "created_at": createdAt.toIso8601String(),
        "firebaseToken": firebaseToken,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "status": status,
        "updated_at": updatedAt.toIso8601String(),
    };
}
