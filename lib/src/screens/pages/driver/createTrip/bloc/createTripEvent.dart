import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'package:equatable/equatable.dart';

abstract class CreateTripEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class InitializeTrip extends CreateTripEvent {
  final String pickUpText;
  final String destinationText;
  final TimeAndDistanceValues timeAndDistanceValues;
  final DriverMapBookingInfoState state;

  InitializeTrip({
    required this.pickUpText,
    required this.destinationText,
    required this.timeAndDistanceValues,
    required this.state,
  });

  @override
  List<Object?> get props => [pickUpText, destinationText, timeAndDistanceValues, state];
}

class UpdateVehicle extends CreateTripEvent {
  final String vehicle;

  UpdateVehicle({required this.vehicle});

  @override
  List<Object?> get props => [vehicle];
}

class UpdateAvailableSeats extends CreateTripEvent {
  final int seats;

  UpdateAvailableSeats({required this.seats});

  @override
  List<Object?> get props => [seats];
}

class UpdateDepartureTime extends CreateTripEvent {
  final String time;

  UpdateDepartureTime({required this.time});

  @override
  List<Object?> get props => [time];
}