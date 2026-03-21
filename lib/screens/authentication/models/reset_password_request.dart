// To parse this JSON data, do
//
//     final resetPasswordRequest = resetPasswordRequestFromJson(jsonString);

import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) => ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) => json.encode(data.toJson());

class ResetPasswordRequest {
    String email;
    String code;
    String newPassword;
    String confirmPassword;

    ResetPasswordRequest({
        required this.email,
        required this.code,
        required this.newPassword,
        required this.confirmPassword,
    });

    factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
        email: json["email"],
        code: json["code"],
        newPassword: json["newPassword"],
        confirmPassword: json["confirmPassword"],
    );

    Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
        "newPassword": newPassword,
        "confirmPassword": confirmPassword,
    };
}
