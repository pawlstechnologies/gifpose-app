// To parse this JSON data, do
//
//     final notificationResponse = notificationResponseFromJson(jsonString);

import 'dart:convert';

NotificationResponse notificationResponseFromJson(String str) => NotificationResponse.fromJson(json.decode(str));

String notificationResponseToJson(NotificationResponse data) => json.encode(data.toJson());

class NotificationResponse {
    bool status;
    String message;
    NotificationResponseData data;

    NotificationResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    factory NotificationResponse.fromJson(Map<String, dynamic> json) => NotificationResponse(
        status: json["status"],
        message: json["message"],
        data: NotificationResponseData.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class NotificationResponseData {
    int total;
    int unreadCount;
    List<Notifications> notifications;

    NotificationResponseData({
        required this.total,
        required this.unreadCount,
        required this.notifications,
    });

    factory NotificationResponseData.fromJson(Map<String, dynamic> json) => NotificationResponseData(
        total: json["total"],
        unreadCount: json["unreadCount"],
        notifications: List<Notifications>.from(json["notifications"].map((x) => Notifications.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "total": total,
        "unreadCount": unreadCount,
        "notifications": List<dynamic>.from(notifications.map((x) => x.toJson())),
    };
}

class Notifications {
    String id;
    String deviceId;
    String userId;
    String title;
    String message;
    String type;
    bool read;
    String? img;
    NotificationData data;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    Notifications({
        required this.id,
        required this.deviceId,
        required this.userId,
        required this.title,
        required this.message,
        required this.type,
        required this.read,
        this.img,
        required this.data,
        required this.createdAt,
        required this.updatedAt,
        required this.v,
    });

    factory Notifications.fromJson(Map<String, dynamic> json) => Notifications(
        id: json["_id"],
        deviceId: json["deviceId"],
        userId: json["userId"],
        title: json["title"],
        message: json["message"],
        type: json["type"],
        read: json["read"],
        img: json["img"],
        data: NotificationData.fromJson(json["data"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "deviceId": deviceId,
        "userId": userId,
        "title": title,
        "message": message,
        "type": type,
        "read": read,
        "img": img,
        "data": data.toJson(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class NotificationData {
    String itemId;

    NotificationData({
        required this.itemId,
    });

    factory NotificationData.fromJson(Map<String, dynamic> json) => NotificationData(
        itemId: json["itemId"],
    );

    Map<String, dynamic> toJson() => {
        "itemId": itemId,
    };
}
