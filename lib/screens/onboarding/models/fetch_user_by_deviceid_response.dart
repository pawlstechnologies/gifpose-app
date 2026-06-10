// To parse this JSON data, do
//
//     final fetchUserByDeviceId = fetchUserByDeviceIdFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

FetchUserByDeviceId fetchUserByDeviceIdFromJson(String str) => FetchUserByDeviceId.fromJson(json.decode(str));

String fetchUserByDeviceIdToJson(FetchUserByDeviceId data) => json.encode(data.toJson());

class FetchUserByDeviceId {
    bool status;
    String message;
    Data data;

    FetchUserByDeviceId({
        required this.status,
        required this.message,
        required this.data,
    });

    factory FetchUserByDeviceId.fromJson(Map<String, dynamic> json) => FetchUserByDeviceId(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    Location location;
    bool adEnabled;
    bool isPremium;
    String id;
    String deviceId;
    int v;
    String address;
    String city;
    DateTime createdAt;
    String firebaseToken;
    double lat;
    double lng;
    int miles;
    String postCode;
    DateTime updatedAt;

    Data({
        required this.location,
        required this.adEnabled,
        required this.isPremium,
        required this.id,
        required this.deviceId,
        required this.v,
        required this.address,
        required this.city,
        required this.createdAt,
        required this.firebaseToken,
        required this.lat,
        required this.lng,
        required this.miles,
        required this.postCode,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        location: Location.fromJson(json["location"]),
        adEnabled: json["adEnabled"],
        isPremium: json["isPremium"],
        id: json["_id"],
        deviceId: json["deviceId"],
        v: json["__v"],
        address: json["address"],
        city: json["city"],
        createdAt: DateTime.parse(json["createdAt"]),
        firebaseToken: json["firebaseToken"],
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        miles: json["miles"],
        postCode: json["postCode"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "location": location.toJson(),
        "adEnabled": adEnabled,
        "isPremium": isPremium,
        "_id": id,
        "deviceId": deviceId,
        "__v": v,
        "address": address,
        "city": city,
        "createdAt": createdAt.toIso8601String(),
        "firebaseToken": firebaseToken,
        "lat": lat,
        "lng": lng,
        "miles": miles,
        "postCode": postCode,
        "updatedAt": updatedAt.toIso8601String(),
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
