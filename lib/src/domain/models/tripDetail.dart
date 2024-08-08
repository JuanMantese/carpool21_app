import 'dart:convert';
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/reserve.dart';

TripDetail passengerRequestFromJson(String str) => TripDetail.fromJson(json.decode(str));

String passengerRequestToJson(TripDetail data) => json.encode(data.toJson());

class TripDetail {
  int idTrip;
  int idDriver;
  Driver? driver;
  String pickupNeighborhood;
  String pickupText;
  double pickupLat;
  double pickupLng;
  String destinationNeighborhood;
  String destinationText;
  double destinationLat;
  double destinationLng;
  int availableSeats;
  String departureTime; // Date Format
  double? distance; // En kilometros
  int? timeDifference; // En minutos
  double? compensation;
  CarInfo? vehicle;
  String? observations;
  List<Reserve>? reserves;

  // GoogleDistanceMatrix? googleDistanceMatrix;
  // Position pickupPosition;
  // Position destinationPosition;

  TripDetail({
    required this.idTrip,
    required this.idDriver,
    this.driver,
    required this.pickupNeighborhood,
    required this.pickupText,
    required this.pickupLat,
    required this.pickupLng,
    required this.destinationNeighborhood,
    required this.destinationText,
    required this.destinationLat,
    required this.destinationLng,
    required this.availableSeats,
    required this.departureTime,
    this.distance,
    this.timeDifference,
    this.compensation,
    this.vehicle,
    this.observations,
    this.reserves,
    // this.googleDistanceMatrix,
    // required this.pickupPosition,
    // required this.destinationPosition,
  });

  // Recibe una Lista con la informacion de todos los viajes disponibles y la convierte en JSON
  static List<TripDetail> fromJsonList(List<dynamic> jsonList) {
    List<TripDetail> toList = [];

    jsonList.forEach((json) { 
      TripDetail clientRequestResponse = TripDetail.fromJson(json);
      toList.add(clientRequestResponse);
    });
    return toList;
  }

  factory TripDetail.fromJson(Map<String, dynamic> json) => TripDetail(
    idTrip: json["idTrip"],
    idDriver: json["idDriver"],
    driver: json["driver"] != null ? Driver.fromJson(json["driver"]) : null,
    pickupNeighborhood: json["pickupNeighborhood"],
    pickupText: json["pickupText"],
    pickupLat: json["pickupLat"]?.toDouble(),
    pickupLng: json["pickupLng"]?.toDouble(),
    destinationNeighborhood: json["destinationNeighborhood"],
    destinationText: json["destinationText"],
    destinationLat: json["destinationLat"]?.toDouble(),
    destinationLng: json["destinationLng"]?.toDouble(),
    availableSeats: json["availableSeats"],
    departureTime: json["departureTime"],
    distance: json["distance"]?.toDouble(),
    timeDifference: json["timeDifference"],
    compensation: json["compensation"]?.toDouble(),
    vehicle: json["vehicle"] != null ? CarInfo.fromJson(json["vehicle"]) : null,
    observations: json["observations"],
    reserves: json["reserves"] != null ? List<Reserve>.from(json["reserves"].map((x) => Reserve.fromJson(x))) : null,
    // googleDistanceMatrix: json["google_distance_matrix"] != null ? GoogleDistanceMatrix.fromJson(json["google_distance_matrix"]) : null, 
    // pickupPosition: Position.fromJson(json["pickup_position"]),
    // destinationPosition: Position.fromJson(json["destination_position"]),
  );

  Map<String, dynamic> toJson() => {
    "id": idTrip,
    "idDriver": idDriver,
    "driver": driver?.toJson(),
    "pickupNeighborhood": pickupNeighborhood,
    "pickupText": pickupText,
    "pickuplat": pickupLat,
    "pickupLng": pickupLng,
    "destinationNeighborhood": destinationNeighborhood,
    "destinationText": destinationText,
    "destinationLat": destinationLat,
    "destinationLng": destinationLng,
    "availableSeats": availableSeats,
    "departureTime": departureTime,
    "distance": distance,
    "timeDifference": timeDifference,
    "compensation": compensation,
    "vehicle": vehicle?.toJson(),
    "observations": observations,
    "reserves": reserves != null ? List<dynamic>.from(reserves!.map((x) => x.toJson())) : null,
    // "google_distance_matrix": googleDistanceMatrix?.toJson(),
    // "pickup_position": pickupPosition.toJson(),
    // "destination_position": destinationPosition.toJson(),
  };
}

class Driver {
  String name;
  String lastName;
  String phone;
  String? photo;

  Driver({
    required this.name,
    required this.lastName,
    required this.phone,
    this.photo,
  });

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
    name: json["name"],
    lastName: json["lastName"],
    phone: json["phone"],
    photo: json["photo"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "lastName": lastName,
    "phone": phone,
    "photoUser": photo,
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