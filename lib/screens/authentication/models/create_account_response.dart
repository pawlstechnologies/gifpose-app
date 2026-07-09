// To parse this JSON data, do
//
//     final createAccountResponse = createAccountResponseFromJson(jsonString);

import 'dart:convert';

CreateAccountResponse createAccountResponseFromJson(String str) => CreateAccountResponse.fromJson(json.decode(str));

String createAccountResponseToJson(CreateAccountResponse data) => json.encode(data.toJson());

class CreateAccountResponse {
    bool status;
    String message;
    Data data;

    CreateAccountResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory CreateAccountResponse.fromJson(Map<String, dynamic> json) => CreateAccountResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"] ?? json),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String userId;
    String fullname;
    String email;
    String username;

    Data({
        required this.userId,
        required this.fullname,
        required this.email,
        required this.username,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        userId: json["userId"] ?? "",
        fullname: json["fullname"] ?? "",
        email: json["email"] ?? "",
        username: json["username"] ?? "",
    );

    Map<String, dynamic> toJson() => {
        "userId": userId,
        "fullname": fullname,
        "email": email,
        "username": username,
    };
}
