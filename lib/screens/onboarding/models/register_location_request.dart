// To parse this JSON data, do
//
//     final registerLocationRequest = registerLocationRequestFromJson(jsonString);

import 'dart:convert';

RegisterLocationRequest registerLocationRequestFromJson(String str) => RegisterLocationRequest.fromJson(json.decode(str));

String registerLocationRequestToJson(RegisterLocationRequest data) => json.encode(data.toJson());

class RegisterLocationRequest {
    String postcode;
    String deviceId;
    double? miles;
      String firebaseToken;


    RegisterLocationRequest({
        required this.postcode,
        required this.deviceId,
        required this.miles,
                required this.firebaseToken,
    });

    factory RegisterLocationRequest.fromJson(Map<String, dynamic> json) => RegisterLocationRequest(
        postcode: json["postcode"],
        deviceId: json["deviceId"],
        miles: json["miles"],
          firebaseToken: json["firebaseToken"],
    );

    Map<String, dynamic> toJson() => {
        "postcode": postcode,
        "deviceId": deviceId,
        "miles": miles,
         "firebaseToken": firebaseToken,
    };
}
