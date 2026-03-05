// To parse this JSON data, do
//
//     final searchCategoryPredictionRequest = searchCategoryPredictionRequestFromJson(jsonString);

import 'dart:convert';

SearchCategoryPredictionRequest searchCategoryPredictionRequestFromJson(String str) => SearchCategoryPredictionRequest.fromJson(json.decode(str));

String searchCategoryPredictionRequestToJson(SearchCategoryPredictionRequest data) => json.encode(data.toJson());

class SearchCategoryPredictionRequest {
    List<String> keywords;

    SearchCategoryPredictionRequest({
        required this.keywords,
    });

    factory SearchCategoryPredictionRequest.fromJson(Map<String, dynamic> json) => SearchCategoryPredictionRequest(
        keywords: List<String>.from(json["keywords"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
    };
}
