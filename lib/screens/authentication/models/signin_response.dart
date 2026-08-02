// To parse this JSON data, do
//
//     final signInResponse = signInResponseFromJson(jsonString);

import 'dart:convert';

SignInResponse signInResponseFromJson(String str) => SignInResponse.fromJson(json.decode(str));

String signInResponseToJson(SignInResponse data) => json.encode(data.toJson());

class SignInResponse {
    bool status;
    String message;
    Data data;

    SignInResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory SignInResponse.fromJson(dynamic source) {
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

        return SignInResponse(
            status: json["status"] is bool ? json["status"] : false,
            message: json["message"]?.toString() ?? "",
            data: Data.fromJson(json["data"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    String accessToken;
    String refreshToken;
    User user;

    Data({
        required this.accessToken,
        required this.refreshToken,
        required this.user,
    });

    factory Data.fromJson(dynamic source) {
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

        return Data(
            accessToken: json["accessToken"]?.toString() ?? "",
            refreshToken: json["refreshToken"]?.toString() ?? "",
            user: User.fromJson(json["user"]),
        );
    }

    Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
        "user": user.toJson(),
    };
}

class User {
    String id;
    String fullname;
    String email;
    String username;

    User({
        required this.id,
        required this.fullname,
        required this.email,
        required this.username,
    });

    factory User.fromJson(dynamic source) {
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

        return User(
            id: json["id"]?.toString() ?? "",
            fullname: json["fullname"]?.toString() ?? "",
            email: json["email"]?.toString() ?? "",
            username: json["username"]?.toString() ?? "",
        );
    }

    Map<String, dynamic> toJson() => {
        "id": id,
        "fullname": fullname,
        "email": email,
        "username": username,
    };
}
