import 'dart:convert';

CarInfo carInfoFromJson(String str) => CarInfo.fromJson(json.decode(str));

String carInfoToJson(CarInfo data) => json.encode(data.toJson());

class CarInfo {
    int? idDriver;
    String brand;
    String model;
    String patent;
    String color;
    int nroGreenCard;
    int nroCarInsurance;
 

    CarInfo({
      this.idDriver,
      required this.brand,
      required this.model,
      required this.patent,
      required this.color,
      required this.nroGreenCard,
      required this.nroCarInsurance,
    });

    factory CarInfo.fromJson(Map<String, dynamic> json) => CarInfo(
      idDriver: json["id_driver"],
      brand: json["brand"],
      model: json["model"],
      patent: json["patent"],
      color: json["color"],
      nroGreenCard: json["nroGreenCard"],
      nroCarInsurance: json["nroCarInsurance"],
    );

    Map<String, dynamic> toJson() => {
      "id_driver": idDriver,
      "brand": brand,
      "model": model,
      "plate": patent,
      "color": color,
      "nroGreenCard": nroGreenCard,
      "nroCarInsurance": nroCarInsurance,
    };
}