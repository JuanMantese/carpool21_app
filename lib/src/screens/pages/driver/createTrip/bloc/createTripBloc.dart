import 'package:bloc/bloc.dart';
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/driverTripRequest.dart';
import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/driverTripRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'createTripEvent.dart';
import 'createTripState.dart';

class CreateTripBloc extends Bloc<CreateTripEvent, CreateTripState> {

  AuthUseCases authUseCases;
  DriverTripRequestsUseCases driverTripRequestsUseCases;

  CreateTripBloc(this.authUseCases, this.driverTripRequestsUseCases) : super(CreateTripState(
    pickUpText: '',
    pickUpLatLng: null,
    destinationText: '',
    destinationLatLng: null,
    timeAndDistanceValues: TimeAndDistanceValues(
      tripPrice: 1000.0,
      distance: Distance(text: "", value: 0.0),
      duration: Duration(text: "", value: 0.0),
    ),
    state: DriverMapBookingInfoState(),
  )) {

    on<InitializeTrip>((event, emit) {
      emit(state.copyWith(
        pickUpText: event.pickUpText,
        pickUpLatLng: event.pickUpLatLng,
        destinationText: event.destinationText,
        destinationLatLng: event.destinationLatLng,
        timeAndDistanceValues: event.timeAndDistanceValues,
        state: event.state,
      ));
    });

    on<UpdateNeighborhood>((event, emit) {
      emit(state.copyWith(neighborhood: event.neighborhood));
    });

    on<UpdateVehicle>((event, emit) {
      emit(state.copyWith(selectedVehicle: event.vehicle));
    });

    on<UpdateAvailableSeats>((event, emit) {
      emit(state.copyWith(availableSeats: event.seats));
    });

    on<UpdateTripDescription>((event, emit) {
      emit(state.copyWith(tripDescription: event.tripDescription));
    });


    // Creando un viaje
    on<CreateTripRequest>((event, emit) async {
      print('Creando Viaje');
      print(state.pickUpText);
      print(state.pickUpLatLng!.latitude);
      print(state.pickUpLatLng!.longitude);
      print(state.destinationText);
      print(state.destinationLatLng!.latitude);
      print(state.destinationLatLng!.longitude);
      print(state.neighborhood);
      print(state.selectedVehicle);
      print(state.availableSeats);
      print(state.tripDescription);


      AuthResponse? authResponse = await authUseCases.getUserSession.run();

      Resource<int> response = await driverTripRequestsUseCases.createTripRequestUseCase.run(
        DriverTripRequest(
          idDriver: authResponse?.user.id ?? 1, 
          idVehicle: 1,
          idCompensation: 1,
          pickupNeighborhood: 'Centro',
          pickupText: state.pickUpText, 
          pickupLat: state.pickUpLatLng!.latitude, 
          pickupLng: state.pickUpLatLng!.longitude, 
          destinationNeighborhood: 'US21',
          destinationText: state.destinationText, 
          destinationLat: state.destinationLatLng!.latitude, 
          destinationLng: state.destinationLatLng!.longitude,
          availableSeats: state.availableSeats!,
          departureTime: state.departureTime!,
        )
      );

      // Traigo la respuesta que me devuelve el Back al crear un viaje
      emit(
        state.copyWith(
          responseDriverTripRequest: response
        )
      );
    });
  }
}