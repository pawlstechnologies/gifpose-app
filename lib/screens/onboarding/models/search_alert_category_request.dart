// To parse this JSON data, do
//
//     final searchCategoryPredictionResponse = searchCategoryPredictionResponseFromJson(jsonString);

import 'dart:convert';

SearchCategoryPredictionResponse searchCategoryPredictionResponseFromJson(
  String str,
) => SearchCategoryPredictionResponse.fromJson(json.decode(str));

String searchCategoryPredictionResponseToJson(
  SearchCategoryPredictionResponse data,
) => json.encode(data.toJson());

class SearchCategoryPredictionResponse {
  bool success;
  String message;
  List<String> contents;
  Data data;

  SearchCategoryPredictionResponse({
    required this.success,
    required this.message,
    required this.contents,
    required this.data,
  });

  factory SearchCategoryPredictionResponse.fromJson(
    Map<String, dynamic> json,
  ) => SearchCategoryPredictionResponse(
    success: json["success"],
    message: json["message"],
    contents: List<String>.from(json["contents"].map((x) => x)),
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "contents": List<dynamic>.from(contents.map((x) => x)),
    "data": data.toJson(),
  };
}

class Data {
  int totalCount;
  List<Subcategory> subcategories;
  List<Content> contents;

  Data({
    required this.totalCount,
    required this.subcategories,
    required this.contents,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalCount: json["totalCount"],
    subcategories: List<Subcategory>.from(
      json["subcategories"].map((x) => Subcategory.fromJson(x)),
    ),
    contents: List<Content>.from(
      json["contents"].map((x) => Content.fromJson(x)),
    ),
  );

  Map<String, dynamic> toJson() => {
    "totalCount": totalCount,
    "subcategories": List<dynamic>.from(subcategories.map((x) => x.toJson())),
    "contents": List<dynamic>.from(contents.map((x) => x.toJson())),
  };
}

class Content {
  String id;
  String name;
  Status status;
  String subcategoryId;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  String subcategoryName;
  String categoryName;

  Content({
    required this.id,
    required this.name,
    required this.status,
    required this.subcategoryId,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.subcategoryName,
    required this.categoryName,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
    id: json["_id"],
    name: json["name"],
    status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
    subcategoryId: json["subcategoryId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updatedAt: DateTime.parse(json["updatedAt"]),
    slug: json["slug"],
    subcategoryName: json["subcategoryName"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "status": statusValues.reverse[status],
    "subcategoryId": subcategoryId,
    "createdAt": createdAt.toIso8601String(),
    "updatedAt": updatedAt.toIso8601String(),
    "slug": slug,
    "subcategoryName": subcategoryName,
    "categoryName": categoryName,
  };
}

enum Status { ACTIVE, UNKNOWN }

final statusValues = EnumValues({"Active": Status.ACTIVE});

class Subcategory {
  String id;
  String name;
  String categoryId;
  Status status;
  DateTime createdAt;
  DateTime updatedAt;
  String slug;
  String categoryName;

  Subcategory({
    required this.id,
    required this.name,
    required this.categoryId,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.slug,
    required this.categoryName,
  });

  factory Subcategory.fromJson(Map<String, dynamic> json) => Subcategory(
    id: json["_id"],
    name: json["name"],
    categoryId: json["categoryId"],
    status: statusValues.map[json["status"]] ?? Status.UNKNOWN,
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
    slug: json["slug"],
    categoryName: json["categoryName"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "categoryId": categoryId,
    "status": statusValues.reverse[status],
    "created_at": createdAt.toIso8601String(),
    "updated_at": updatedAt.toIso8601String(),
    "slug": slug,
    "categoryName": categoryName,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
