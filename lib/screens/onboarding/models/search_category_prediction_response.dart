// To parse this JSON data, do
//
//     final searchCategoryPredictionResponse = searchCategoryPredictionResponseFromJson(jsonString);

import 'dart:convert';

SearchCategoryPredictionResponse searchCategoryPredictionResponseFromJson(String str) => SearchCategoryPredictionResponse.fromJson(json.decode(str));

String searchCategoryPredictionResponseToJson(SearchCategoryPredictionResponse data) => json.encode(data.toJson());

class SearchCategoryPredictionResponse {
    bool success;
    int total;
    List<Datum> data;

    SearchCategoryPredictionResponse({
        required this.success,
        required this.total,
        required this.data,
    });

    factory SearchCategoryPredictionResponse.fromJson(Map<String, dynamic> json) => SearchCategoryPredictionResponse(
        success: json["success"],
        total: json["total"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "total": total,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String id;
    String name;
    String status;
    String slug;

    Datum({
        required this.id,
        required this.name,
        required this.status,
        required this.slug,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        status: json["status"],
        slug: json["slug"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "status": status,
        "slug": slug,
    };
}
