// To parse this JSON data, do
//
//     final alertListCategoryResponse = alertListCategoryResponseFromJson(jsonString);

import 'dart:convert';

AlertListCategoryResponse alertListCategoryResponseFromJson(String str) => AlertListCategoryResponse.fromJson(json.decode(str));

String alertListCategoryResponseToJson(AlertListCategoryResponse data) => json.encode(data.toJson());

class AlertListCategoryResponse {
    bool success;
    String message;
    Data data;

    AlertListCategoryResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AlertListCategoryResponse.fromJson(Map<String, dynamic> json) => AlertListCategoryResponse(
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
    List<CategoryListData> data;
    int total;
    int page;
    int totalPages;

    Data({
        required this.data,
        required this.total,
        required this.page,
        required this.totalPages,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        data: List<CategoryListData>.from(json["data"].map((x) => CategoryListData.fromJson(x))),
        total: json["total"],
        page: json["page"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "total": total,
        "page": page,
        "totalPages": totalPages,
    };
}

class CategoryListData {
    String id;
    String name;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String slug;
    int v;

    CategoryListData({
        required this.id,
        required this.name,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.slug,
        required this.v,
    });

    factory CategoryListData.fromJson(Map<String, dynamic> json) => CategoryListData(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
    };
}
