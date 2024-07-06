
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/createTripRequestUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/getAllTripsUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/getTimeAndDistanceUseCase.dart';

class DriverTripRequestsUseCases {

  CreateTripRequestUseCase createTripRequestUseCase;
  GetTimeAndDistanceUseCase getTimeAndDistance;
  
  // Get Current Trip
  // Get Historical Trips
  // Get Next Trips
  GetAllTripsUseCase getAllTripsUseCase;

  DriverTripRequestsUseCases({
    required this.createTripRequestUseCase,
    required this.getTimeAndDistance,
    required this.getAllTripsUseCase
  });

}