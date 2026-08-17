import 'dart:convert';

UpdateSubscriptionStatusResponse updateSubscriptionStatusResponseFromJson(String str) =>
    UpdateSubscriptionStatusResponse.fromJson(json.decode(str));

String updateSubscriptionStatusResponseToJson(UpdateSubscriptionStatusResponse data) =>
    json.encode(data.toJson());

class UpdateSubscriptionStatusResponse {
  final bool success;
  final String message;
  final dynamic data;

  UpdateSubscriptionStatusResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory UpdateSubscriptionStatusResponse.fromJson(dynamic source) {
    Map<String, dynamic> json;
    if (source is String) {
      try {
        json = jsonDecode(source) as Map<String, dynamic>;
      } catch (_) {
        json = {};
      }
    } else if (source is Map) {
      json = Map<String, dynamic>.from(source);
    } else {
      json = {};
    }

    return UpdateSubscriptionStatusResponse(
      success: json["success"] is bool
          ? json["success"]
          : (json["success"] == "true" || json["status"] == true || json["status"] == "true"),
      message: json["message"]?.toString() ?? "",
      data: json["data"],
    );
  }

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}
