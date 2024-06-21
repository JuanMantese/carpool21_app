
import 'package:carpool_21_app/src/data/dataSource/remote/services/passengerRequestService.dart';
import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/domain/repository/passengerRequestRepository.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

class PassengerRequestRepositoryImpl implements PassengerRequestRepository {
  
  PassengerRequestsService passengerRequestsService;

  PassengerRequestRepositoryImpl(this.passengerRequestsService);

  @override
  Future<Resource<List<PassengerRequest>>> getNearbyTripRequest(double driverLat, double driverLng) {
    return passengerRequestsService.getNearbyTripRequest(driverLat, driverLng);
  }
  

}