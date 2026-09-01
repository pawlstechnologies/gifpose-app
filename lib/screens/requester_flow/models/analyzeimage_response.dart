// To parse this JSON data, do
//
//     final analyseImageResponse = analyseImageResponseFromJson(jsonString);

import 'dart:convert';

AnalyseImageResponse analyseImageResponseFromJson(String str) =>
    AnalyseImageResponse.fromJson(json.decode(str));

String analyseImageResponseToJson(AnalyseImageResponse data) =>
    json.encode(data.toJson());

class AnalyseImageResponse {
  String message;
  Data data;

  AnalyseImageResponse({required this.message, required this.data});

  factory AnalyseImageResponse.fromJson(Map<String, dynamic> json) =>
      AnalyseImageResponse(
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {"message": message, "data": data.toJson()};
}

class Data {
  String name;
  String description;
  Category category;
  dynamic suggestedCategory;
  List<String> images;

  Data({
    required this.name,
    required this.description,
    required this.category,
    required this.suggestedCategory,
    required this.images,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    name: json["name"],
    description: json["description"],
    category: Category.fromJson(json["category"]),
    suggestedCategory: json["suggestedCategory"],
    images: List<String>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "description": description,
    "category": category.toJson(),
    "suggestedCategory": suggestedCategory,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}

class Subcategory {
  String id;
  String name;
  String categoryId;
  String status;
  String slug;
  List<Category> contents;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.status,
    required this.slug,
    required this.contents,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["_id"],
    name: json["name"],
    categoryId: json["categoryId"],
    status: json["status"],
    slug: json["slug"],
    contents: List<Category>.from(
      json["contents"].map((x) => Category.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "categoryId": categoryId,
    "status": status,
    "slug": slug,
    "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
  };
}

class Category {
  String id;
  String name;
  String slug;
  String status;
  List<Subcategory>? subcategories;
  String? subcategoryId;

  Category({
    required this.id,
    required this.name,
    required this.slug,
    required this.status,
    this.subcategories,
    this.subcategoryId,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    id: json["_id"],
    name: json["name"],
    slug: json["slug"],
    status: json["status"],
    subcategories: json["subcategories"] == null
        ? []
        : List<Subcategory>.from(
            json["subcategories"]!.map((x) => Subcategory.fromJson(x)),
          ),
    subcategoryId: json["subcategoryId"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "slug": slug,
    "status": status,
    "subcategories": subcategories == null
        ? []
        : List<dynamic>.from(subcategories!.map((x) => x.toJson())),
    "subcategoryId": subcategoryId,
  };
}
