// To parse this JSON data, do
//
//     final fetchItemsbyIdResponse = fetchItemsbyIdResponseFromJson(jsonString);

import 'dart:convert';

FetchItemsbyIdResponse fetchItemsbyIdResponseFromJson(String str) => FetchItemsbyIdResponse.fromJson(json.decode(str));

String fetchItemsbyIdResponseToJson(FetchItemsbyIdResponse data) => json.encode(data.toJson());

class FetchItemsbyIdResponse {
    bool success;
    String message;
    Data data;

    FetchItemsbyIdResponse({
        required this.success,
        required this.message,
        required this.data,
    });

    factory FetchItemsbyIdResponse.fromJson(Map<String, dynamic> json) => FetchItemsbyIdResponse(
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
    String description;
    List<String> imageUrls;
    String category;
    String subCategory;
    Location location;
    String city;
    String country;
    bool pickup;
    DateTime expiration;
    String url;
    String partner;
    int visitCount;
    double distanceInMeters;
    double distanceInMiles;
    EstimatedTravelTime estimatedTravelTime;
    DateTime createdAt;

    Data({
        required this.id,
        required this.name,
        required this.description,
        required this.imageUrls,
        required this.category,
        required this.subCategory,
        required this.location,
        required this.city,
        required this.country,
        required this.pickup,
        required this.expiration,
        required this.url,
        required this.partner,
        required this.visitCount,
        required this.distanceInMeters,
        required this.distanceInMiles,
        required this.estimatedTravelTime,
        required this.createdAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
        imageUrls: List<String>.from(json["imageUrls"].map((x) => x)),
        category: json["category"],
        subCategory: json["subCategory"],
        location: Location.fromJson(json["location"]),
        city: json["city"],
        country: json["country"],
        pickup: json["pickup"],
        expiration: DateTime.parse(json["expiration"]),
        url: json["url"],
        partner: json["partner"],
        visitCount: json["visitCount"],
        distanceInMeters: json["distanceInMeters"]?.toDouble(),
        distanceInMiles: json["distanceInMiles"]?.toDouble(),
        estimatedTravelTime: EstimatedTravelTime.fromJson(json["estimatedTravelTime"]),
        createdAt: DateTime.parse(json["createdAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "description": description,
        "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
        "category": category,
        "subCategory": subCategory,
        "location": location.toJson(),
        "city": city,
        "country": country,
        "pickup": pickup,
        "expiration": expiration.toIso8601String(),
        "url": url,
        "partner": partner,
        "visitCount": visitCount,
        "distanceInMeters": distanceInMeters,
        "distanceInMiles": distanceInMiles,
        "estimatedTravelTime": estimatedTravelTime.toJson(),
        "createdAt": createdAt.toIso8601String(),
    };
}

class EstimatedTravelTime {
    String walking;
    String cycling;
    String carPrivate;
    String carHire;
    String publicTransport;

    EstimatedTravelTime({
        required this.walking,
        required this.cycling,
        required this.carPrivate,
        required this.carHire,
        required this.publicTransport,
    });

    factory EstimatedTravelTime.fromJson(Map<String, dynamic> json) => EstimatedTravelTime(
        walking: json["walking"],
        cycling: json["cycling"],
        carPrivate: json["carPrivate"],
        carHire: json["carHire"],
        publicTransport: json["publicTransport"],
    );

    Map<String, dynamic> toJson() => {
        "walking": walking,
        "cycling": cycling,
        "carPrivate": carPrivate,
        "carHire": carHire,
        "publicTransport": publicTransport,
    };
}

class Location {
    String type;
    List<double> coordinates;

    Location({
        required this.type,
        required this.coordinates,
    });

    factory Location.fromJson(Map<String, dynamic> json) => Location(
        type: json["type"],
        coordinates: List<double>.from(json["coordinates"].map((x) => x?.toDouble())),
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
    };
}
