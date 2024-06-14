import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/driverTripRequest.dart';
import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class DriverTripRequestsService {

  // Consultamos al Back cual es el Tiempo estimado del viaje y su Distancia del origen al destino
  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat, 
    double originLng, 
    double destinationLat, 
    double destinationLng
  ) async {

    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/driver-trip-requests/${originLat}/${originLng}/${destinationLat}/${destinationLng}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        TimeAndDistanceValues timeAndDistanceValues = TimeAndDistanceValues.fromJson(data);
        return Success(timeAndDistanceValues);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }

  // Creacion de un viaje
  Future<Resource<int>> create(DriverTripRequest driverTripRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/driver-trip-requests');
      Map<String, String> headers = { 'Content-Type': 'application/json' };
      String body = json.encode(driverTripRequest);

      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success(data);
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