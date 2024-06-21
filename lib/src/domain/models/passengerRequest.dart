import 'dart:convert';

import 'package:carpool_21_app/src/domain/models/carInfo.dart';

PassengerRequest passengerRequestFromJson(String str) => PassengerRequest.fromJson(json.decode(str));

String passengerRequestToJson(PassengerRequest data) => json.encode(data.toJson());

class PassengerRequest {
  int id;
  int idDriver;
  int idCompensation;
  String pickupText;
  double pickupLat;
  double pickupLng;
  String destinationText;
  double destinationLat;
  double destinationLng;
  int availableSeats;
  String departureTime;
  Position pickupPosition;
  Position destinationPosition;
  double? distance;
  String? timeDifference;
  CarInfo? car;
  DateTime? createdAt;
  DateTime updatedAt;
  double? fareAssigned;
  GoogleDistanceMatrix? googleDistanceMatrix;

  PassengerRequest({
    required this.id,
    required this.idDriver,
    required this.idCompensation,
    required this.pickupText,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationText,
    required this.destinationLat,
    required this.destinationLng,
    required this.availableSeats,
    required this.departureTime,
    required this.pickupPosition,
    required this.destinationPosition,
    this.distance,
    this.timeDifference,
    this.car,
    this.createdAt,
    required this.updatedAt,
    this.fareAssigned,
    this.googleDistanceMatrix,
  });

  // Recibe una Lista con la informacion de todos los viajes disponibles y la convierte en JSON
  static List<PassengerRequest> fromJsonList(List<dynamic> jsonList) {
    List<PassengerRequest> toList = [];

    jsonList.forEach((json) { 
      PassengerRequest clientRequestResponse = PassengerRequest.fromJson(json);
      toList.add(clientRequestResponse);
    });
    return toList;
  }

  factory PassengerRequest.fromJson(Map<String, dynamic> json) => PassengerRequest(
    id: json["id"],
    idDriver: json["idDriver"],
    idCompensation: json["idCompensation"],
    pickupText: json["pickupText"],
    pickupLat: json["pickupLat"]?.toDouble(),
    pickupLng: json["pickupLng"]?.toDouble(),
    destinationText: json["destinationText"],
    destinationLat: json["destinationLat"]?.toDouble(),
    destinationLng: json["destinationLng"]?.toDouble(),
    availableSeats: json["availableSeats"],
    departureTime: json["departureTime"],
    pickupPosition: Position.fromJson(json["pickup_position"]),
    destinationPosition: Position.fromJson(json["destination_position"]),
    distance: json["distance"]?.toDouble(),
    timeDifference: json["time_difference"],
    car: json["car"] != null ? CarInfo.fromJson(json["car"]) : null,
    createdAt: json["created_at"] != null ? DateTime.parse(json["created_at"]) : null,
    updatedAt: DateTime.parse(json["updated_at"]),
    fareAssigned: json["fare_assigned"]?.toDouble(),
    googleDistanceMatrix: json["google_distance_matrix"] != null ? GoogleDistanceMatrix.fromJson(json["google_distance_matrix"]) : null, 
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "idDriver": idDriver,
    "idCompensation": idCompensation,
    "pickupText": pickupText,
    "pickuplat": pickupLat,
    "pickupLng": pickupLng,
    "destinationText": destinationText,
    "destinationLat": destinationLat,
    "destinationLng": destinationLng,
    "availableSeats": availableSeats,
    "departureTime": departureTime,
    "pickup_position": pickupPosition.toJson(),
    "destination_position": destinationPosition.toJson(),
    "distance": distance,
    "time_difference": timeDifference,
    "car": car?.toJson(),
    "updated_at": updatedAt.toIso8601String(),
    "fare_assigned": fareAssigned,
    "google_distance_matrix": googleDistanceMatrix?.toJson(),
  };
}

class Position {
  double x;
  double y;

  Position({
    required this.x,
    required this.y,
  });

  factory Position.fromJson(Map<String, dynamic> json) => Position(
    x: json["x"]?.toDouble(),
    y: json["y"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "x": x,
    "y": y,
  };
}

class GoogleDistanceMatrix {
  Distance distance;
  Distance duration;
  String status;

  GoogleDistanceMatrix({
    required this.distance,
    required this.duration,
    required this.status,
  });

  factory GoogleDistanceMatrix.fromJson(Map<String, dynamic> json) => GoogleDistanceMatrix(
    distance: Distance.fromJson(json["distance"]),
    duration: Distance.fromJson(json["duration"]),
    status: json["status"],
  );

  Map<String, dynamic> toJson() => {
    "distance": distance.toJson(),
    "duration": duration.toJson(),
    "status": status,
  };
}

class Distance {
  String text;
  int value;

  Distance({
    required this.text,
    required this.value,
  });

  factory Distance.fromJson(Map<String, dynamic> json) => Distance(
    text: json["text"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "text": text,
    "value": value,
  };
}