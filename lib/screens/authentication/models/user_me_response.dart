import 'dart:convert';

UserMeResponse userMeResponseFromJson(String str) => UserMeResponse.fromJson(json.decode(str));

String userMeResponseToJson(UserMeResponse data) => json.encode(data.toJson());

class UserMeResponse {
    final bool status;
    final String message;
    final UserMe? user;

    UserMeResponse({
        required this.status,
        required this.message,
        this.user,
    });

    factory UserMeResponse.fromJson(dynamic source) {
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

        dynamic userData = json["user"] ?? json["data"];
        if (userData is Map && userData.containsKey("user")) {
            userData = userData["user"];
        }

        return UserMeResponse(
            status: json["status"] is bool ? json["status"] : (json["status"] == "true" || json["status"] == 1),
            message: json["message"]?.toString() ?? "",
            user: userData != null ? UserMe.fromJson(userData) : null,
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "user": user?.toJson(),
    };
}

class UserMe {
    final String id;
    final String deviceId;
    final String fullname;
    final String email;
    final String username;
    final bool isVerified;
    final DateTime createdAt;
    final DateTime updatedAt;
    final int v;
    final String? refreshToken;

    UserMe({
        required this.id,
        required this.deviceId,
        required this.fullname,
        required this.email,
        required this.username,
        required this.isVerified,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
        this.refreshToken,
    });

    factory UserMe.fromJson(dynamic source) {
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

        DateTime parseDate(dynamic raw) {
            if (raw is String && raw.isNotEmpty) {
                return DateTime.tryParse(raw) ?? DateTime.now();
            } else if (raw is DateTime) {
                return raw;
            }
            return DateTime.now();
        }

        return UserMe(
            id: (json["_id"] ?? json["id"])?.toString() ?? "",
            deviceId: json["deviceId"]?.toString() ?? "",
            fullname: json["fullname"]?.toString() ?? "",
            email: json["email"]?.toString() ?? "",
            username: json["username"]?.toString() ?? "",
            isVerified: json["isVerified"] is bool ? json["isVerified"] : false,
            createdAt: parseDate(json["createdAt"]),
            updatedAt: parseDate(json["updatedAt"]),
            v: json["__v"] is int ? json["__v"] : 0,
            refreshToken: json["refreshToken"]?.toString(),
        );
    }

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "fullname": fullname,
        "email": email,
        "username": username,
        "isVerified": isVerified,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "refreshToken": refreshToken,
    };
}
