import 'dart:convert';

UpdateSubscriptionStatusRequest updateSubscriptionStatusRequestFromJson(String str) =>
    UpdateSubscriptionStatusRequest.fromJson(json.decode(str));

String updateSubscriptionStatusRequestToJson(UpdateSubscriptionStatusRequest data) =>
    json.encode(data.toJson());

class UpdateSubscriptionStatusRequest {
  final String subscriptionId;
  final String status;

  UpdateSubscriptionStatusRequest({
    required this.subscriptionId,
    required this.status,
  });

  factory UpdateSubscriptionStatusRequest.fromJson(Map<String, dynamic> json) =>
      UpdateSubscriptionStatusRequest(
        subscriptionId: json["subscriptionId"]?.toString() ?? "",
        status: json["status"]?.toString() ?? "",
      );

  Map<String, dynamic> toJson() => {
        "subscriptionId": subscriptionId,
        "status": status,
      };
}
