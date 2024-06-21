
import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:equatable/equatable.dart';

class TripsAvailableState extends Equatable {

  // Resource para traer la información
  final Resource? response;

  final List<PassengerRequest>? testingArrayTrips;

  TripsAvailableState({
    this.response,
    this.testingArrayTrips
  });

  TripsAvailableState copyWith({
    Resource? response,
    List<PassengerRequest>? testingArrayTrips
  }) {
    return TripsAvailableState(
      response: response,
      testingArrayTrips: testingArrayTrips
    );
  }
  
  @override
  List<Object?> get props => [response, testingArrayTrips];

}