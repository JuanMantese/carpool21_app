
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/createTripRequestUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/getTimeAndDistanceUseCase.dart';

class DriverTripRequestsUseCases {

  CreateTripRequestUseCase createTripRequestUseCase;
  GetTimeAndDistanceUseCase getTimeAndDistance;

  DriverTripRequestsUseCases({
    required this.createTripRequestUseCase,
    required this.getTimeAndDistance,
  });

}