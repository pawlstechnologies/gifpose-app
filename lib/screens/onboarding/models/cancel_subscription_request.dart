import 'dart:convert';

CancelSubscriptionRequest cancelSubscriptionRequestFromJson(String str) =>
    CancelSubscriptionRequest.fromJson(json.decode(str));

String cancelSubscriptionRequestToJson(CancelSubscriptionRequest data) =>
    json.encode(data.toJson());

class CancelSubscriptionRequest {
  final String subscriptionId;
  final bool cancelImmediately;

  CancelSubscriptionRequest({
    required this.subscriptionId,
    this.cancelImmediately = false,
  });

  factory CancelSubscriptionRequest.fromJson(Map<String, dynamic> json) =>
      CancelSubscriptionRequest(
        subscriptionId: json["subscriptionId"],
        cancelImmediately: json["cancelImmediately"] ?? false,
      );

  Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "cancelImmediately": cancelImmediately,
      };
}
