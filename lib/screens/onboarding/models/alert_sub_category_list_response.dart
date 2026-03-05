// To parse this JSON data, do
//
//     final alertListSubCategoryResponse = alertListSubCategoryResponseFromJson(jsonString);

import 'dart:convert';

AlertListSubCategoryResponse alertListSubCategoryResponseFromJson(String str) => AlertListSubCategoryResponse.fromJson(json.decode(str));

String alertListSubCategoryResponseToJson(AlertListSubCategoryResponse data) => json.encode(data.toJson());

class AlertListSubCategoryResponse {
    bool success;
    String message;
    Data data;

    AlertListSubCategoryResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory AlertListSubCategoryResponse.fromJson(Map<String, dynamic> json) => AlertListSubCategoryResponse(
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
    String id;
    String name;
    String status;
    List<Subcategory> subcategories;

    Data({
        required this.id,
        required this.name,
        required this.status,
        required this.subcategories,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    };
}

class Subcategory {
    String id;
    String name;
    String categoryId;
    String status;
    DateTime createdAt;
    DateTime updatedAt;
    String slug;
    int v;
    List<Content> contents;

    Subcategory({
        required this.id,
        required this.name,
        required this.categoryId,
        required this.status,
        required this.createdAt,
        required this.updatedAt,
        required this.slug,
        required this.v,
        required this.contents,
    });

    factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
        id: json["_id"],
        name: json["name"],
        categoryId: json["categoryId"],
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        slug: json["slug"],
        v: json["__v"],
        contents: List<Content>.from(json["contents"].map((x) => Content.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "categoryId": categoryId,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
        "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
    };
}

class Content {
    String id;
    String name;
    String status;
    String subcategoryId;
    DateTime createdAt;
    DateTime updatedAt;
    String slug;
    int v;

    Content({
        required this.id,
        required this.name,
        required this.status,
        required this.subcategoryId,
        required this.createdAt,
        required this.updatedAt,
        required this.slug,
        required this.v,
    });

    factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        subcategoryId: json["subcategoryId"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        slug: json["slug"],
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "subcategoryId": subcategoryId,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "slug": slug,
        "__v": v,
    };
}
