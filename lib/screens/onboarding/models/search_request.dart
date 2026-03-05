// To parse this JSON data, do
//
//     final searchRequest = searchRequestFromJson(jsonString);

import 'dart:convert';

SearchRequest searchRequestFromJson(String str) => SearchRequest.fromJson(json.decode(str));

String searchRequestToJson(SearchRequest data) => json.encode(data.toJson());

class SearchRequest {
    List<String> keywords;

    SearchRequest({
        required this.keywords,
    });

    factory SearchRequest.fromJson(Map<String, dynamic> json) => SearchRequest(
        keywords: List<String>.from(json["keywords"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "keywords": List<dynamic>.from(keywords.map((x) => x)),
    };
}
