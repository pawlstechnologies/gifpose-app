// To parse this JSON data, do
//
//     final fetchAlertListResponse = fetchAlertListResponseFromJson(jsonString);

import 'dart:convert';

FetchAlertListResponse fetchAlertListResponseFromJson(String str) => FetchAlertListResponse.fromJson(json.decode(str));

String fetchAlertListResponseToJson(FetchAlertListResponse data) => json.encode(data.toJson());

class FetchAlertListResponse {
    bool success;
    List<Datum> data;
    int total;
    int page;
    int totalPages;

    FetchAlertListResponse({
        required this.success,
        required this.data,
        required this.total,
        required this.page,
        required this.totalPages,
    });

    factory FetchAlertListResponse.fromJson(Map<String, dynamic> json) => FetchAlertListResponse(
        success: json["success"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        total: json["total"],
        page: json["page"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "totalPages": totalPages,
    };
}

class Datum {
    String id;
    String deviceId;
    List<dynamic> categories;
    List<String> keywords;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Datum({
        required this.id,
        required this.deviceId,
        required this.categories,
        required this.keywords,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        deviceId: json["deviceId"],
        categories: List<dynamic>.from(json["categories"].map((x) => x)),
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "categories": List<dynamic>.from(categories.map((x) => x)),
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "__v": v,
    };
}
