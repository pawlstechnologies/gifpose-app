// To parse this JSON data, do
//
//     final fetchItemsbyIdResponse = fetchItemsbyIdResponseFromJson(jsonString);

import 'dart:convert';

FetchItemsbyIdResponse fetchItemsbyIdResponseFromJson(String str) =>
    FetchItemsbyIdResponse.fromJson(json.decode(str));

String fetchItemsbyIdResponseToJson(FetchItemsbyIdResponse data) =>
    json.encode(data.toJson());

class FetchItemsbyIdResponse {
  bool success;
  String message;
  Data data;

  FetchItemsbyIdResponse({
    required this.success,
    required this.message,
    required this.data,
  });

  factory FetchItemsbyIdResponse.fromJson(dynamic source) {
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

    return FetchItemsbyIdResponse(
      success: json["success"] is bool
          ? json["success"]
          : (json["status"] == true || json["success"] == "true"),
      message: json["message"]?.toString() ?? "",
      data: json["data"] != null
          ? Data.fromJson(json["data"])
          : Data.empty(),
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.toJson(),
  };
}

class Data {
  String id;
  String name;
  String description;
  List<String> imageUrls;
  String category;
  String subCategory;
  Location location;
  String city;
  String country;
  bool pickup;
  DateTime expiration;
  String url;
  String partner;
  int visitCount;
  double distanceInMeters;
  double distanceInMiles;
  EstimatedTravelTime estimatedTravelTime;
  DateTime createdAt;

  Data({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrls,
    required this.category,
    required this.subCategory,
    required this.location,
    required this.city,
    required this.country,
    required this.pickup,
    required this.expiration,
    required this.url,
    required this.partner,
    required this.visitCount,
    required this.distanceInMeters,
    required this.distanceInMiles,
    required this.estimatedTravelTime,
    required this.createdAt,
  });

  factory Data.empty() => Data(
    id: "",
    name: "",
    description: "",
    imageUrls: [],
    category: "",
    subCategory: "",
    location: Location(type: "Point", coordinates: [0.0, 0.0]),
    city: "",
    country: "",
    pickup: false,
    expiration: DateTime.now(),
    url: "",
    partner: "",
    visitCount: 0,
    distanceInMeters: 0.0,
    distanceInMiles: 0.0,
    estimatedTravelTime: EstimatedTravelTime(
      walking: "",
      cycling: "",
      carPrivate: "",
      carHire: "",
      publicTransport: "",
    ),
    createdAt: DateTime.now(),
  );

  factory Data.fromJson(dynamic source) {
    if (source is! Map) {
      return Data.empty();
    }
    final json = Map<String, dynamic>.from(source);

    DateTime parseDate(dynamic val) {
      if (val is String && val.isNotEmpty) {
        return DateTime.tryParse(val) ?? DateTime.now();
      } else if (val is DateTime) {
        return val;
      }
      return DateTime.now();
    }

    List<String> parseImages(dynamic val) {
      if (val is List) {
        return val
            .map((x) => x?.toString() ?? "")
            .where((s) => s.isNotEmpty)
            .toList();
      }
      return [];
    }

    return Data(
      id: (json["_id"] ?? json["id"])?.toString() ?? "",
      name: json["name"]?.toString() ?? "",
      description: json["description"]?.toString() ?? "",
      imageUrls: parseImages(json["imageUrls"]),
      category: json["category"]?.toString() ?? "",
      subCategory: json["subCategory"]?.toString() ?? "",
      location: json["location"] != null
          ? Location.fromJson(json["location"])
          : Location(type: "Point", coordinates: [0.0, 0.0]),
      city: json["city"]?.toString() ?? "",
      country: json["country"]?.toString() ?? "",
      pickup: json["pickup"] is bool
          ? json["pickup"]
          : (json["pickup"] == 1 || json["pickup"] == "true"),
      expiration: parseDate(json["expiration"]),
      url: json["url"]?.toString() ?? "",
      partner: json["partner"]?.toString() ?? "",
      visitCount: json["visitCount"] is num
          ? (json["visitCount"] as num).toInt()
          : (int.tryParse(json["visitCount"]?.toString() ?? "0") ?? 0),
      distanceInMeters: json["distanceInMeters"] is num
          ? (json["distanceInMeters"] as num).toDouble()
          : (double.tryParse(json["distanceInMeters"]?.toString() ?? "0.0") ?? 0.0),
      distanceInMiles: json["distanceInMiles"] is num
          ? (json["distanceInMiles"] as num).toDouble()
          : (double.tryParse(json["distanceInMiles"]?.toString() ?? "0.0") ?? 0.0),
      estimatedTravelTime: json["estimatedTravelTime"] != null
          ? EstimatedTravelTime.fromJson(json["estimatedTravelTime"])
          : EstimatedTravelTime(
              walking: "",
              cycling: "",
              carPrivate: "",
              carHire: "",
              publicTransport: "",
            ),
      createdAt: parseDate(json["createdAt"]),
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "description": description,
    "imageUrls": List<dynamic>.from(imageUrls.map((x) => x)),
    "category": category,
    "subCategory": subCategory,
    "location": location.toJson(),
    "city": city,
    "country": country,
    "pickup": pickup,
    "expiration": expiration.toIso8601String(),
    "url": url,
    "partner": partner,
    "visitCount": visitCount,
    "distanceInMeters": distanceInMeters,
    "distanceInMiles": distanceInMiles,
    "estimatedTravelTime": estimatedTravelTime.toJson(),
    "createdAt": createdAt.toIso8601String(),
  };
}

class EstimatedTravelTime {
  String walking;
  String cycling;
  String carPrivate;
  String carHire;
  String publicTransport;

  EstimatedTravelTime({
    required this.walking,
    required this.cycling,
    required this.carPrivate,
    required this.carHire,
    required this.publicTransport,
  });

  factory EstimatedTravelTime.fromJson(dynamic source) {
    if (source is! Map) {
      return EstimatedTravelTime(
        walking: "",
        cycling: "",
        carPrivate: "",
        carHire: "",
        publicTransport: "",
      );
    }
    final json = Map<String, dynamic>.from(source);
    return EstimatedTravelTime(
      walking: json["walking"]?.toString() ?? "",
      cycling: json["cycling"]?.toString() ?? "",
      carPrivate: json["carPrivate"]?.toString() ?? "",
      carHire: json["carHire"]?.toString() ?? "",
      publicTransport: json["publicTransport"]?.toString() ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
    "walking": walking,
    "cycling": cycling,
    "carPrivate": carPrivate,
    "carHire": carHire,
    "publicTransport": publicTransport,
  };
}

class Location {
  String type;
  List<double> coordinates;

  Location({
    required this.type,
    required this.coordinates,
  });

  factory Location.fromJson(dynamic source) {
    if (source is! Map) {
      return Location(type: "Point", coordinates: [0.0, 0.0]);
    }
    final json = Map<String, dynamic>.from(source);
    return Location(
      type: json["type"]?.toString() ?? "Point",
      coordinates: json["coordinates"] is List
          ? (json["coordinates"] as List)
              .map((x) => x is num ? x.toDouble() : (double.tryParse(x?.toString() ?? "0.0") ?? 0.0))
              .toList()
          : [0.0, 0.0],
    );
  }

  Map<String, dynamic> toJson() => {
    "type": type,
    "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
  };
}
