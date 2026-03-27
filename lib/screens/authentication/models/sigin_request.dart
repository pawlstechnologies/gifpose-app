// To parse this JSON data, do
//
//     final signInRequest = signInRequestFromJson(jsonString);

import 'dart:convert';

SignInRequest signInRequestFromJson(String str) => SignInRequest.fromJson(json.decode(str));

String signInRequestToJson(SignInRequest data) => json.encode(data.toJson());

class SignInRequest {
    String identifier;
    String password;

    SignInRequest({
        required this.identifier,
        required this.password,
    });

    factory SignInRequest.fromJson(Map<String, dynamic> json) => SignInRequest(
        identifier: json["identifier"],
        password: json["password"],
    );

    Map<String, dynamic> toJson() => {
        "identifier": identifier,
        "password": password,
    };
}
