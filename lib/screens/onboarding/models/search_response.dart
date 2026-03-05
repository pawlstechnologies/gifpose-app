// To parse this JSON data, do
//
//     final searchResponse = searchResponseFromJson(jsonString);

import 'dart:convert';

SearchResponse searchResponseFromJson(String str) => SearchResponse.fromJson(json.decode(str));

String searchResponseToJson(SearchResponse data) => json.encode(data.toJson());

class SearchResponse {
    bool success;
    String message;
    int page;
    int perPage;

    Data data;

    SearchResponse({
        required this.success,
        required this.message,
        required this.page,
        required this.perPage,

        required this.data,
    });

    factory SearchResponse.fromJson(Map<String, dynamic> json) => SearchResponse(
        success: json["success"],
        message: json["message"],
        page: json["page"],
    
        perPage: json["perPage"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "page": page,
                
        "perPage": perPage,
        "data": data.toJson(),
    };
}

class Data {
    UserLocationSearch userLocation;
    List<SearchData> items;

    Data({
        required this.userLocation,
        required this.items,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userLocation: UserLocationSearch.fromJson(json["userLocation"]),
        items: List<SearchData>.from(json["items"].map((x) => SearchData.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "userLocation": userLocation.toJson(),
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
    };
}

class SearchData {
    String id;
    String name;
    String description;
    String category;
    String subCategory;
    String partner;
    String thumbnail;
    int visitCount;
    double distanceInMeters;
    double distanceInMiles;

    SearchData({
        required this.id,
        required this.name,
        required this.description,
        required this.category,
        required this.subCategory,
        required this.partner,
        required this.thumbnail,
        required this.visitCount,
        required this.distanceInMeters,
        required this.distanceInMiles,
    });

    factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        category: json["category"],
        subCategory: json["subCategory"],
        partner: json["partner"],
        thumbnail: json["thumbnail"],
        visitCount: json["visitCount"],
        distanceInMeters: json["distanceInMeters"]?.toDouble(),
        distanceInMiles: json["distanceInMiles"]?.toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "category": category,
        "subCategory": subCategory,
        "partner": partner,
        "thumbnail": thumbnail,
        "visitCount": visitCount,
        "distanceInMeters": distanceInMeters,
        "distanceInMiles": distanceInMiles,
        
    };
}

class UserLocationSearch {
    String deviceId;
    String postcode;
    String city;
    int setMile;

    UserLocationSearch({
        required this.deviceId,
        required this.postcode,
        required this.city,
        required this.setMile,
    });

    factory UserLocationSearch.fromJson(Map<String, dynamic> json) => UserLocationSearch(
        deviceId: json["deviceId"],
        postcode: json["postcode"],
        city: json["city"],
        setMile: json["setMile"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "postcode": postcode,
        "city": city,
        "setMile": setMile,
    };
}
