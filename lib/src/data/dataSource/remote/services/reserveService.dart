import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/reserveDetail.dart';
import 'package:carpool_21_app/src/domain/models/reserveRequest.dart';
import 'package:carpool_21_app/src/domain/models/reservesAll.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;


class ReserveService {

  Future<String> token;

  // Constructor
  ReserveService(this.token);

  Future<Resource<ReserveDetail>> create(ReserveRequest reserveRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/trip-reservation/reserve-seat');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(reserveRequest.toJson());

      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        ReserveDetail reserveDetail = ReserveDetail.fromJson(data);
        return Success(reserveDetail);
      } else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error CreateReserve: $error');
      return ErrorData(error.toString());
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