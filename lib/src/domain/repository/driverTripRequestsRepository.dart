
import 'package:carpool_21_app/src/domain/models/driverTripRequest.dart';
import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

abstract class DriverTripRequestsRepository {

  Future<Resource<TimeAndDistanceValues>> getTimeAndDistanceClientRequets(
    double originLat,
    double originLng,
    double destinationLat,
    double destinationLng,
  );

  Future<Resource<int>> create(DriverTripRequest driverTripRequest);

}