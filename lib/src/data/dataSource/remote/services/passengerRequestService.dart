import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class PassengerRequestsService {

  // Consultando todos los viajes disponibles - getNearbyTripRequest: Consultando viajes cercanos
  Future<Resource<List<PassengerRequest>>> getNearbyTripRequest(double driverLat, double driverLng) async {

    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/passenger-requests/${driverLat}/${driverLng}');
      Map<String, String> headers = { 'Content-Type': 'application/json' };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Devuelve una lista con todos los viajes cercanos
        List<PassengerRequest> clientRequests = PassengerRequest.fromJsonList(data); 
        return Success(clientRequests);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }


}