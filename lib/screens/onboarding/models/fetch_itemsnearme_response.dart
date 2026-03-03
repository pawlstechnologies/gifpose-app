// To parse this JSON data, do
//
//     final fetchItemsNearMeResponse = fetchItemsNearMeResponseFromJson(jsonString);

import 'dart:convert';

FetchItemsNearMeResponse fetchItemsNearMeResponseFromJson(String str) => FetchItemsNearMeResponse.fromJson(json.decode(str));

String fetchItemsNearMeResponseToJson(FetchItemsNearMeResponse data) => json.encode(data.toJson());

class FetchItemsNearMeResponse {
    bool success;
    String message;
    int count;
    UserLocation userLocation;
    List<FetchItemsNearMeData> data;
    int page;
    int perPage;
    int total;
    int totalPages;

    FetchItemsNearMeResponse({
        required this.success,
        required this.message,
        required this.count,
        required this.userLocation,
        required this.data,
        required this.page,
        required this.perPage,
        required this.total,
        required this.totalPages,
    });

    factory FetchItemsNearMeResponse.fromJson(Map<String, dynamic> json) => FetchItemsNearMeResponse(
        success: json["success"],
        message: json["message"],
        count: json["count"],
        userLocation: UserLocation.fromJson(json["userLocation"]),
        data: List<FetchItemsNearMeData>.from(json["data"].map((x) => FetchItemsNearMeData.fromJson(x))),
        page: json["page"],
        perPage: json["perPage"],
        total: json["total"],
        totalPages: json["totalPages"],
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "count": count,
        "userLocation": userLocation.toJson(),
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "page": page,
        "perPage": perPage,
        "total": total,
        "totalPages": totalPages,
    };
}

class FetchItemsNearMeData {
    String id;
    String name;
    String description;
    String partner;
    String thumbnail;
    int visitCount;
    double distanceInMeters;
    double distanceInMiles;

    FetchItemsNearMeData({
        required this.id,
        required this.name,
        required this.description,
        required this.partner,
        required this.thumbnail,
        required this.visitCount,
        required this.distanceInMeters,
        required this.distanceInMiles,
    });

    factory FetchItemsNearMeData.fromJson(Map<String, dynamic> json) => FetchItemsNearMeData(
        id: json["_id"],
        name: json["name"],
        description: json["description"],
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
        "partner": partner,
        "thumbnail": thumbnail,
        "visitCount": visitCount,
        "distanceInMeters": distanceInMeters,
        "distanceInMiles": distanceInMiles,
    };
}

class UserLocation {
    String deviceId;
    String postcode;
    String city;
    int setMile;

    UserLocation({
        required this.deviceId,
        required this.postcode,
        required this.city,
        required this.setMile,
    });

    factory UserLocation.fromJson(Map<String, dynamic> json) => UserLocation(
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
