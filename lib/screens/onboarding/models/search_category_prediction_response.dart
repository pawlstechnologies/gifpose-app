// To parse this JSON data, do
//
//     final searchAlertPredictionsResponse = searchAlertPredictionsResponseFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

SearchAlertPredictionsResponse searchAlertPredictionsResponseFromJson(String str) => SearchAlertPredictionsResponse.fromJson(json.decode(str));

String searchAlertPredictionsResponseToJson(SearchAlertPredictionsResponse data) => json.encode(data.toJson());

class SearchAlertPredictionsResponse {
    final bool success;
    final String message;
    final List<String> keywords;
    final List<Datum> data;

    SearchAlertPredictionsResponse({
        required this.success,
        required this.message,
        required this.keywords,
        required this.data,
    });

    factory SearchAlertPredictionsResponse.fromJson(Map<String, dynamic> json) => SearchAlertPredictionsResponse(
        success: json["success"],
        message: json["message"],
        keywords: List<String>.from(json["keywords"].map((x) => x)),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String id;
    final String name;
    final String slug;
    final String status;
    final List<Subcategory> subcategories;

    Datum({
        required this.id,
        required this.name,
        required this.slug,
        required this.status,
        required this.subcategories,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        slug: json["slug"],
        status: json["status"],
        subcategories: List<Subcategory>.from(json["subcategories"].map((x) => Subcategory.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "slug": slug,
        "status": status,
        "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    };
}

class Subcategory {
    final String id;
    final String name;
    final String categoryId;
    final String status;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String slug;
    final int v;
    final List<Content> contents;

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
    final String id;
    final String name;
    final String status;
    final String subcategoryId;
    final DateTime createdAt;
    final DateTime updatedAt;
    final String slug;
    final int v;

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
