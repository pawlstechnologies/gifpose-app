// To parse this JSON data, do
//
//     final changePlanRequest = changePlanRequestFromJson(jsonString);

import 'dart:convert';

ChangePlanRequest changePlanRequestFromJson(String str) =>
    ChangePlanRequest.fromJson(json.decode(str));

String changePlanRequestToJson(ChangePlanRequest data) =>
    json.encode(data.toJson());

class ChangePlanRequest {
  final String plan;

  ChangePlanRequest({
    required this.plan,
  });

  factory ChangePlanRequest.fromJson(Map<String, dynamic> json) =>
      ChangePlanRequest(
        plan: json["plan"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "plan": plan,
      };
}
