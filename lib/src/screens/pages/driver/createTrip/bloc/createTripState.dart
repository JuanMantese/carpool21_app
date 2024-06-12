import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'package:equatable/equatable.dart';

class CreateTripState extends Equatable {
  final String? selectedVehicle;
  final int? availableSeats;
  final String? departureTime;
  final String pickUpText;
  final String destinationText;
  final TimeAndDistanceValues timeAndDistanceValues;
  final DriverMapBookingInfoState state;

  CreateTripState({
    this.selectedVehicle,
    this.availableSeats,
    this.departureTime,
    required this.pickUpText,
    required this.destinationText,
    required this.timeAndDistanceValues,
    required this.state,
  });

  CreateTripState copyWith({
    String? selectedVehicle,
    int? availableSeats,
    String? departureTime,
    String? pickUpText,
    String? destinationText,
    TimeAndDistanceValues? timeAndDistanceValues,
    DriverMapBookingInfoState? state,
  }) {
    return CreateTripState(
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      availableSeats: availableSeats ?? this.availableSeats,
      departureTime: departureTime ?? this.departureTime,
      pickUpText: pickUpText ?? this.pickUpText,
      destinationText: destinationText ?? this.destinationText,
      timeAndDistanceValues: timeAndDistanceValues ?? this.timeAndDistanceValues,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [
    selectedVehicle,
    availableSeats,
    departureTime,
    pickUpText,
    destinationText,
    timeAndDistanceValues,
    state,
  ];
}