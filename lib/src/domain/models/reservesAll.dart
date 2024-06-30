import 'package:carpool_21_app/src/domain/models/tripDetail.dart';

class ReservesAll {
  TripDetail currentReserve;
  List<TripDetail> futureReserves;
  List<TripDetail> historicalReserves;

  ReservesAll({
   required this.currentReserve,
    required this.futureReserves,
    required this.historicalReserves,
  });

  factory ReservesAll.fromJson(Map<String, dynamic> json) => ReservesAll(
    currentReserve: TripDetail.fromJson(json["currentReserve"]),
    futureReserves: List<TripDetail>.from(json["futureReserves"].map((x) => TripDetail.fromJson(x))),
    historicalReserves: List<TripDetail>.from(json["historicalReserves"].map((x) => TripDetail.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    'currentReserve': currentReserve.toJson(),
    'futureReserves': List<dynamic>.from(futureReserves.map((x) => x.toJson())),
    'historicalReserves': List<dynamic>.from(historicalReserves.map((x) => x.toJson())),
  };
}