// To parse this JSON data, do
//
//     final reportListingRequest = reportListingRequestFromJson(jsonString);

import 'dart:convert';

ReportListingRequest reportListingRequestFromJson(String str) => ReportListingRequest.fromJson(json.decode(str));

String reportListingRequestToJson(ReportListingRequest data) => json.encode(data.toJson());

class ReportListingRequest {
    final String deviceId;
    final String reason;

    ReportListingRequest({
        required this.deviceId,
        required this.reason,
    });

    factory ReportListingRequest.fromJson(Map<String, dynamic> json) => ReportListingRequest(
        deviceId: json["deviceId"],
        reason: json["reason"],
    );

    Map<String, dynamic> toJson() => {
        "deviceId": deviceId,
        "reason": reason,
    };
}
