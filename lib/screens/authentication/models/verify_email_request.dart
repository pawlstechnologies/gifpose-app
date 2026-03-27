// To parse this JSON data, do
//
//     final verifyEmailAddressRequest = verifyEmailAddressRequestFromJson(jsonString);

import 'dart:convert';

VerifyEmailAddressRequest verifyEmailAddressRequestFromJson(String str) => VerifyEmailAddressRequest.fromJson(json.decode(str));

String verifyEmailAddressRequestToJson(VerifyEmailAddressRequest data) => json.encode(data.toJson());

class VerifyEmailAddressRequest {
    String email;
    String code;

    VerifyEmailAddressRequest({
        required this.email,
        required this.code,
    });

    factory VerifyEmailAddressRequest.fromJson(Map<String, dynamic> json) => VerifyEmailAddressRequest(
        email: json["email"],
        code: json["code"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
    };
}
