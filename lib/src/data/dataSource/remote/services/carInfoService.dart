import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class CarInfoService {

  Future<String> token;

  // Constructor
  CarInfoService(this.token);

  // Registrando un nuevo vehiculo
  Future<Resource<bool>> create(CarInfo carInfo) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/driver-car-info');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(carInfo);

      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  // To update a carInfo data, we need the Session Token
  Future<Resource<CarInfo>> update(int idDriver, CarInfo car) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/car/$idDriver'); // Creation of the URL path
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      }; // We specify that the information sent is of type JSON
      
      String body = json.encode({
        'brand': car.brand,
        'model': car.model, 
        'patent': car.patent,
        'color': car.color,
        'nroGreenCard': car.nroGreenCard,
        'nroCarInsurance': car.nroCarInsurance,
      });

      // Making the request. I specify the URL, the headers and the body
      final response = await http.put(url, headers: headers, body: body);

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        CarInfo carInfoResponse = CarInfo.fromJson(data);
        print('Data Remote: ${car.toJson()}');

        return Success(carInfoResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error: $error');
      return ErrorData(error.toString());
    }
  }

  // Trayendo el vehiculo del conductor
  Future<Resource<CarInfo>> getCarInfo(int idDriver) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/driver-car-info/$idDriver');
      Map<String, String> headers = { 'Content-Type': 'application/json' };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        CarInfo carInfo = CarInfo.fromJson(data);
        return Success(carInfo);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

}