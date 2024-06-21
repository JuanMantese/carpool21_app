  
import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

abstract class PassengerRequestRepository {

  // Consultando todos los viajes disponibles - getNearbyTripRequest: Consultando viajes cercanos
  Future<Resource<List<PassengerRequest>>> getNearbyTripRequest(double driverLat,double driverLng);

}