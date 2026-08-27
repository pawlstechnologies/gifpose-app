// To parse this JSON data, do
//
//     final changePlanResponse = changePlanResponseFromJson(jsonString);

import 'dart:convert';

ChangePlanResponse changePlanResponseFromJson(String str) =>
    ChangePlanResponse.fromJson(json.decode(str));

String changePlanResponseToJson(ChangePlanResponse data) =>
    json.encode(data.toJson());

class ChangePlanResponse {
  final bool? success;
  final String? message;
  final ChangePlanData? data;

  ChangePlanResponse({
    this.success,
    this.message,
    this.data,
  });

  factory ChangePlanResponse.fromJson(Map<String, dynamic>? json) {
    if (json == null) return ChangePlanResponse();
    return ChangePlanResponse(
      success: json["success"] as bool? ?? json["status"] as bool?,
      message: json["message"] as String?,
      data: json["data"] != null && json["data"] is Map<String, dynamic>
          ? ChangePlanData.fromJson(json["data"] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        if (data != null) "data": data!.toJson(),
      };
}

class ChangePlanData {
  final String? clientSecret;
  final String? currentPlan;
  final String? newPlan;
  final String? currentPlanEndsAt;
  final String? newPlanStartsAt;
  final dynamic amount;
  final String? currency;

  ChangePlanData({
    this.clientSecret,
    this.currentPlan,
    this.newPlan,
    this.currentPlanEndsAt,
    this.newPlanStartsAt,
    this.amount,
    this.currency,
  });

  factory ChangePlanData.fromJson(Map<String, dynamic> json) => ChangePlanData(
        clientSecret: json["clientSecret"]?.toString(),
        currentPlan: json["currentPlan"]?.toString(),
        newPlan: json["newPlan"]?.toString(),
        currentPlanEndsAt: json["currentPlanEndsAt"]?.toString(),
        newPlanStartsAt: json["newPlanStartsAt"]?.toString(),
        amount: json["amount"],
        currency: json["currency"]?.toString(),
      );

  Map<String, dynamic> toJson() => {
        "clientSecret": clientSecret,
        "currentPlan": currentPlan,
        "newPlan": newPlan,
        "currentPlanEndsAt": currentPlanEndsAt,
        "newPlanStartsAt": newPlanStartsAt,
        "amount": amount,
        "currency": currency,
      };
}
