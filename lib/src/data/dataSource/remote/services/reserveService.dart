import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/models/reservesAll.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;


class ReserveService {

  Future<String> token;

  // Constructor
  ReserveService(this.token);

  Future<Resource<bool>> create(Reserve reserve) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/reserve');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(reserve.toJson());

      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(true);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  // Trayendo todas las reservas de un pasajero
  Future<Resource<ReservesAll>> getReservesAll() async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/reserves');
      Map<String, String> headers = { 
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        ReservesAll reservesAll = ReservesAll.fromJson(data);
        return Success(reservesAll);
      }
      else {
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error GetReservesAll Service: $error');
      return ErrorData(error.toString());
    }
  }
}