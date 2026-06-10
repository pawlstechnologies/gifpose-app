// To parse this JSON data, do
//
//     final reportListingResponse = reportListingResponseFromJson(jsonString);

import 'dart:convert';

ReportListingResponse reportListingResponseFromJson(String str) => ReportListingResponse.fromJson(json.decode(str));

String reportListingResponseToJson(ReportListingResponse data) => json.encode(data.toJson());

class ReportListingResponse {
    final bool status;
    final String message;

    ReportListingResponse({
        required this.status,
        required this.message,
    });

    factory ReportListingResponse.fromJson(Map<String, dynamic> json) => ReportListingResponse(
        status: json["status"],
        message: json["message"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
    };
}
