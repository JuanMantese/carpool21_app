import 'package:bloc/bloc.dart';
import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'createTripEvent.dart';
import 'createTripState.dart';

class CreateTripBloc extends Bloc<CreateTripEvent, CreateTripState> {
  CreateTripBloc() : super(CreateTripState(
    pickUpText: '',
    destinationText: '',
    timeAndDistanceValues: TimeAndDistanceValues(
      tripPrice: 0.0,
      destinationAddresses: "",
      originAddresses: "",
      distance: Distance(text: "", value: 0.0),
      duration: Duration(text: "", value: 0.0),
    ),
    state: DriverMapBookingInfoState(),
  )) {
    on<InitializeTrip>((event, emit) {
      emit(state.copyWith(
        pickUpText: event.pickUpText,
        destinationText: event.destinationText,
        timeAndDistanceValues: event.timeAndDistanceValues,
        state: event.state,
      ));
    });

    on<UpdateVehicle>((event, emit) {
      emit(state.copyWith(selectedVehicle: event.vehicle));
    });

    on<UpdateAvailableSeats>((event, emit) {
      emit(state.copyWith(availableSeats: event.seats));
    });

    on<UpdateDepartureTime>((event, emit) {
      emit(state.copyWith(departureTime: event.time));
    });
  }
}