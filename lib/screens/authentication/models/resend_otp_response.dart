// To parse this JSON data, do
//
//     final resendOtpResponse = resendOtpResponseFromJson(jsonString);

import 'dart:convert';

ResendOtpResponse resendOtpResponseFromJson(String str) => ResendOtpResponse.fromJson(json.decode(str));

String resendOtpResponseToJson(ResendOtpResponse data) => json.encode(data.toJson());

class ResendOtpResponse {
  String status;
    String message;

    ResendOtpResponse({
        required this.message,
        required this.status,
    });

    factory ResendOtpResponse.fromJson(Map<String, dynamic> json) => ResendOtpResponse(
        message: json["message"],
        status: json["status"],
    );

    Map<String, dynamic> toJson() => {
        "message": message,
        "status": status,
    };
}
