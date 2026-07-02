// To parse this JSON data, do
import 'dart:convert';

HideItemResponse hideItemResponseFromJson(String str) =>
    HideItemResponse.fromJson(json.decode(str));

String hideItemResponseToJson(HideItemResponse data) =>
    json.encode(data.toJson());

class HideItemResponse {
  bool? status;
  String? message;

  HideItemResponse({
    this.status,
    this.message,
  });

  factory HideItemResponse.fromJson(Map<String, dynamic> json) =>
      HideItemResponse(
        status: json["status"] ?? false,
        message: json["message"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
      };
}