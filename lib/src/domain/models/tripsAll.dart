import 'package:carpool_21_app/src/domain/models/tripDetail.dart';

class TripsAll {
  TripDetail currentTrip;
  List<TripDetail> futureTrips;
  List<TripDetail> historicalTrips;

  TripsAll({
    required this.currentTrip,
    required this.futureTrips,
    required this.historicalTrips,
  });

  factory TripsAll.fromJson(Map<String, dynamic> json) => TripsAll(
    currentTrip: TripDetail.fromJson(json["currentTrip"]),
    futureTrips: List<TripDetail>.from(json["futureTrips"].map((x) => TripDetail.fromJson(x))),
    historicalTrips: List<TripDetail>.from(json["historicalTrips"].map((x) => TripDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'currentTrip': currentTrip.toJson(),
    'futureTrips': List<dynamic>.from(futureTrips.map((x) => x.toJson())),
    'historicalTrips': List<dynamic>.from(historicalTrips.map((x) => x.toJson())),
  };
}