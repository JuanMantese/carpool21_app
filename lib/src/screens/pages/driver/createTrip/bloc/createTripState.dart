import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'package:equatable/equatable.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateTripState extends Equatable {
  final String? selectedVehicle;
  final int? availableSeats;
  final String? departureTime;
  final String pickUpText;
  final LatLng? pickUpLatLng;
  final String destinationText;
  final LatLng? destinationLatLng;
  final TimeAndDistanceValues timeAndDistanceValues;
  final Resource? responseDriverTripRequest;
  final DriverMapBookingInfoState state;

  CreateTripState({
    this.selectedVehicle,
    this.availableSeats,
    this.departureTime,
    required this.pickUpText,
    required this.pickUpLatLng,
    required this.destinationText,
    required this.destinationLatLng,
    required this.timeAndDistanceValues,
    this.responseDriverTripRequest,
    required this.state,
  });

  CreateTripState copyWith({
    String? selectedVehicle,
    int? availableSeats,
    String? departureTime,
    String? pickUpText,
    LatLng? pickUpLatLng,
    String? destinationText,
    LatLng? destinationLatLng,
    TimeAndDistanceValues? timeAndDistanceValues,
    Resource? responseDriverTripRequest,
    DriverMapBookingInfoState? state,
  }) {
    return CreateTripState(
      selectedVehicle: selectedVehicle ?? this.selectedVehicle,
      availableSeats: availableSeats ?? this.availableSeats,
      departureTime: departureTime ?? this.departureTime,
      pickUpText: pickUpText ?? this.pickUpText,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationText: destinationText ?? this.destinationText,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      timeAndDistanceValues: timeAndDistanceValues ?? this.timeAndDistanceValues,
      responseDriverTripRequest: responseDriverTripRequest ?? this.responseDriverTripRequest,
      state: state ?? this.state,
    );
  }

  @override
  List<Object?> get props => [
    selectedVehicle,
    availableSeats,
    departureTime,
    pickUpText,
    pickUpLatLng,
    destinationText,
    destinationLatLng,
    timeAndDistanceValues,
    responseDriverTripRequest,
    state,
  ];
}