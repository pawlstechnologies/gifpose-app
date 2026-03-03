// To parse this JSON data, do
//
//     final registerLocationResponse = registerLocationResponseFromJson(jsonString);

import 'dart:convert';

RegisterLocationResponse registerLocationResponseFromJson(String str) => RegisterLocationResponse.fromJson(json.decode(str));

String registerLocationResponseToJson(RegisterLocationResponse data) => json.encode(data.toJson());

class RegisterLocationResponse {
    bool status;
    String message;
    Data data;

    RegisterLocationResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory RegisterLocationResponse.fromJson(Map<String, dynamic> json) => RegisterLocationResponse(
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
    String id;
    String deviceId;
    int v;
    String address;
    String city;
    DateTime createdAt;
    double lat;
    double lng;
    int miles;
    String postCode;
    DateTime updatedAt;

    Data({
        required this.id,
        required this.deviceId,
        required this.v,
        required this.address,
        required this.city,
        required this.createdAt,
        required this.lat,
        required this.lng,
        required this.miles,
        required this.postCode,
        required this.updatedAt,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["_id"],
        deviceId: json["deviceId"],
        v: json["__v"],
        address: json["address"],
        city: json["city"],
        createdAt: DateTime.parse(json["createdAt"]),
        lat: json["lat"]?.toDouble(),
        lng: json["lng"]?.toDouble(),
        miles: json["miles"],
        postCode: json["postCode"],
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "__v": v,
        "address": address,
        "city": city,
        "createdAt": createdAt.toIso8601String(),
        "lat": lat,
        "lng": lng,
        "miles": miles,
        "postCode": postCode,
        "updatedAt": updatedAt.toIso8601String(),
    };
}
