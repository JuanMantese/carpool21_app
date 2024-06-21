import 'dart:convert';

CarInfo carInfoFromJson(String str) => CarInfo.fromJson(json.decode(str));

String carInfoToJson(CarInfo data) => json.encode(data.toJson());

class CarInfo {
    int? idDriver;
    int? idVehicle;
    String brand;
    String model;
    String patent;
    String color;
    int seats;
    int year;
    String nroGreenCard;
    String? createAt;
    String? updateAT;
    String? dateDelete;
 

    CarInfo({
      this.idDriver,
      this.idVehicle,
      required this.brand,
      required this.model,
      required this.patent,
      required this.color,
      required this.seats,
      required this.year,
      required this.nroGreenCard,
      this.createAt,
      this.updateAT,
      this.dateDelete
    });

  // Recibe una Lista con la informacion de todos los vehiculos del conductor y la convierte en JSON
  static List<CarInfo> fromJsonList(List<dynamic> jsonList) {
    List<CarInfo> toList = [];

    jsonList.forEach((json) { 
      CarInfo carList = CarInfo.fromJson(json);
      toList.add(carList);
    });
    return toList;
  }

    factory CarInfo.fromJson(Map<String, dynamic> json) => CarInfo(
      idDriver: json["idDriver"],
      brand: json["brand"],
      model: json["model"],
      patent: json["patent"],
      color: json["color"],
      seats: json["seats"] is String ? int.parse(json["seats"]) : json["seats"],
      year: json["year"] is String ? int.parse(json["year"]) : json["year"],
      nroGreenCard: json["greenCard"],
    );

    Map<String, dynamic> toJson() => {
      "idDriver": idDriver,
      "brand": brand,
      "model": model,
      "patent": patent,
      "color": color,
      "seats": seats,
      "year": year,
      "greenCard": nroGreenCard,
    };
}