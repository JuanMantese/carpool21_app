import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/driverTripRequest.dart';
import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class DriverTripRequestsService {

  Future<String> token;

  DriverTripRequestsService(this.token);

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
  Future<Resource<TripDetail>> create(DriverTripRequest driverTripRequest) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/trip-request/create');
      Map<String, String> headers = { 
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      };
      String body = json.encode(driverTripRequest);

      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        TripDetail driverTripResponse = TripDetail.fromJson(data);
        return Success(driverTripResponse);
      }
      else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
      
    } catch (error) {
      print('Error CreateTrip: $error');
      return ErrorData(error.toString());
    }
  }

  // Trayendo el vehiculo del conductor
  Future<Resource<TripDetail>> getTripDetail(int idTrip) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/trip-request/findOne/$idTrip');
      Map<String, String> headers = { 
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        TripDetail tripDetail = TripDetail.fromJson(data);
        return Success(tripDetail);
      }
      else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error GetTripDetail Service: $error');
      return ErrorData(error.toString());
    }
  }

  // Trayendo todas las reservas de un pasajero
  Future<Resource<List<TripDetail>>> getAvailableTrips() async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/trip-request/findAll');
      Map<String, String> headers = { 
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      
      if (response.statusCode == 200 || response.statusCode == 201) {
        List<TripDetail> availableTripsAll = TripDetail.fromJsonList(data); 
        return Success(availableTripsAll);
      }
      else {
        print('Response status: ${response.statusCode}');
        print('Response body: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error GetTripsAll Service: $error');
      return ErrorData(error.toString());
    }
  }
}