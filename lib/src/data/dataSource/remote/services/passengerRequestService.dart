import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class PassengerRequestsService {

  Future<String> token;

  PassengerRequestsService(this.token);

  // Consultando todos los viajes disponibles - getNearbyTripRequest: Consultando viajes cercanos
  Future<Resource<List<TripDetail>>> getNearbyTripRequest(double driverLat, double driverLng) async {

    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/passenger-requests/${driverLat}/${driverLng}');

      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      }; // We specify that the information sent is of type JSON

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Devuelve una lista con todos los viajes cercanos
        List<TripDetail> passengerRequests = TripDetail.fromJsonList(data); 
        return Success(passengerRequests);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (e) {
      print('Error: $e');
      return ErrorData(e.toString());
    }
  }


}