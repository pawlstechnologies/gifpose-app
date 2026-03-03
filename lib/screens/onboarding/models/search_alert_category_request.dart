// To parse this JSON data, do
//
//     final searchAlertCategoryResponse = searchAlertCategoryResponseFromJson(jsonString);

import 'dart:convert';

SearchAlertCategoryResponse searchAlertCategoryResponseFromJson(String str) => SearchAlertCategoryResponse.fromJson(json.decode(str));

String searchAlertCategoryResponseToJson(SearchAlertCategoryResponse data) => json.encode(data.toJson());

class SearchAlertCategoryResponse {
    List<String> keywords;

    SearchAlertCategoryResponse({
        required this.keywords,
    });

    factory SearchAlertCategoryResponse.fromJson(Map<String, dynamic> json) => SearchAlertCategoryResponse(
        keywords: List<String>.from(json["keywords"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
    };
}
