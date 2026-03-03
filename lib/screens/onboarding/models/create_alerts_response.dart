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
    String deviceId;
    List<String> categories;
    List<String> keywords;
    String status;
    String id;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Data({
        required this.deviceId,
        required this.categories,
        required this.keywords,
        required this.status,
        required this.id,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        deviceId: json["deviceId"],
        categories: List<String>.from(json["categories"].map((x) => x)),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        status: json["status"],
        id: json["_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "status": status,
        "_id": id,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
    };
}
