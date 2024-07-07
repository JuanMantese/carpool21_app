import 'package:carpool_21_app/src/domain/models/tripDetail.dart';

class ReserveDetail {
  int idReservation;
  bool isPaid;
  TripDetail tripDetail;
  Driver driver; 

  ReserveDetail({
    required this.idReservation,
    required this.isPaid,
    required this.tripDetail,
    required this.driver,
  });

  factory ReserveDetail.fromJson(Map<String, dynamic> json) => ReserveDetail(
    idReservation: json["idReservation"],
    isPaid: json["isPaid"],
    tripDetail: json["tripDetail"],
    driver: json["driver"],
  );

  Map<String, dynamic> toJson() => {
    'idReservation': idReservation,
    'isPaid': isPaid,
    'tripDetail': tripDetail,
    'driver': driver,
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