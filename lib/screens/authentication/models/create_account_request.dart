// To parse this JSON data, do
//
//     final createAccountRequest = createAccountRequestFromJson(jsonString);

import 'dart:convert';

CreateAccountRequest createAccountRequestFromJson(String str) => CreateAccountRequest.fromJson(json.decode(str));

String createAccountRequestToJson(CreateAccountRequest data) => json.encode(data.toJson());

class CreateAccountRequest {
    String fullname;
    String deviceId;
    String username;
    String email;
    String password;
    String confirmPassword;

    CreateAccountRequest({
        required this.fullname,
        required this.deviceId,
        required this.username,
        required this.email,
        required this.password,
        required this.confirmPassword,
    });

    factory CreateAccountRequest.fromJson(Map<String, dynamic> json) => CreateAccountRequest(
        fullname: json["fullname"],
        deviceId: json["deviceId"],
        username: json["username"],
        email: json["email"],
        password: json["password"],
        confirmPassword: json["confirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "fullname": fullname,
        "deviceId": deviceId,
        "username": username,
        "email": email,
        "password": password,
        "confirmPassword": confirmPassword,
    };
}
