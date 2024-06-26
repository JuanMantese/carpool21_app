import 'dart:convert';

DriverTripRequest driverTripRequestFromJson(String str) => DriverTripRequest.fromJson(json.decode(str));

String driverTripRequestToJson(DriverTripRequest data) => json.encode(data.toJson());


class DriverTripRequest {
  int idDriver;
  int idVehicle;
  int idCompensation;
  String pickupNeighborhood;
  String pickupText;
  double pickupLat;
  double pickupLng;
  String destinationNeighborhood;
  String destinationText;
  double destinationLat;
  double destinationLng;
  int availableSeats; // Plazas disponibles
  String departureTime; // Horario de salida
  // CarInfo? car; // Vehiculo del conductor

  DriverTripRequest({
    required this.idDriver,
    required this.idVehicle,
    required this.idCompensation,
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
    // this.car
  });

  factory DriverTripRequest.fromJson(Map<String, dynamic> json) => DriverTripRequest(
    idDriver: json["idDriver"],
    idVehicle: json["idVehicle"],
    idCompensation: json["idCompensation"],
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
  );

  Map<String, dynamic> toJson() => {
    "idDriver": idDriver,
    "idVehicle": idVehicle,
    "idCompensation": idCompensation,
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
  };
}