// To parse this JSON data, do
//
//     final getReportListResponse = getReportListResponseFromJson(jsonString);

import 'dart:convert';

GetReportListResponse getReportListResponseFromJson(String str) => GetReportListResponse.fromJson(json.decode(str));

String getReportListResponseToJson(GetReportListResponse data) => json.encode(data.toJson());

class GetReportListResponse {
    final bool status;
    final String message;
    final List<Datum> data;

    GetReportListResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory GetReportListResponse.fromJson(Map<String, dynamic> json) => GetReportListResponse(
        status: json["status"],
        message: json["message"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    final String code;
    final String label;

    Datum({
        required this.code,
        required this.label,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        code: json["code"],
        label: json["label"],
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "label": label,
    };
}
