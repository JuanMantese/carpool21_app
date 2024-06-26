
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/driverPosition.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/drivers-position/driversPositionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/passenger-request/passengerRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsAvailableBloc extends Bloc<TripsAvailableEvent, TripsAvailableState> {

  AuthUseCases authUseCases;
  DriversPositionUseCases driversPositionUseCases;
  PassengerRequestsUseCases passengerRequestsUseCases;

  TripsAvailableBloc(
    this.authUseCases,
    this.driversPositionUseCases,
    this.passengerRequestsUseCases
  ): super(TripsAvailableState()) {

    // DELETE - Testeando con un objeto de prueba
    void _setTestPassengerRequests(GetNearbyTripRequest event, Emitter<TripsAvailableState> emit) {
      List<TripDetail> toTripsAvailable = [
        TripDetail(
          id: 1,
          idDriver: 101,
          pickupNeighborhood: 'Centro',
          pickupText: "Patio Olmos Shopping, Córdoba, Córdoba Capital, Argentina",
          pickupLat: 37.7749,
          pickupLng: -122.4194,
          destinationNeighborhood: 'Campus Universitario',
          destinationText: "Universidad Siglo 21, De los Latinos, Córdoba, Córdoba Province, Argentina",
          destinationLat: 37.7849,
          destinationLng: -122.4094,
          availableSeats: 3,
          departureTime: "2024-06-15T08:00:00Z",
          // pickupPosition: Position(x: 37.7749, y: -122.4194),
          // destinationPosition: Position(x: 37.7849, y: -122.4094),
          distance: 10.0,
          timeDifference: "15 mins",
          vehicle: CarInfo(brand: "Toyota", model: "Corolla", patent: '123456', color: 'red', nroGreenCard: '1234', seats: 5, year: 2024),
          createdAt: DateTime.parse("2024-06-14T12:00:00Z"),
          updatedAt: DateTime.parse("2024-06-14T12:00:00Z"),
          compensation: 1000.0,
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: "10 km", value: 10000),
            duration: Distance(text: "15 mins", value: 900),
            status: "OK",
          ),
        ),
        TripDetail(
          id: 2,
          idDriver: 102,
          pickupNeighborhood: 'Centro',
          pickupText: "789 Oak St",
          pickupLat: 37.7749,
          pickupLng: -122.4294,
          destinationNeighborhood: 'Campus Universitario',
          destinationText: "123 Pine St",
          destinationLat: 37.7949,
          destinationLng: -122.4194,
          availableSeats: 2,
          departureTime: "2024-06-15T09:00:00Z",
          // pickupPosition: Position(x: 37.7749, y: -122.4294),
          // destinationPosition: Position(x: 37.7949, y: -122.4194),
          distance: 12.0,
          timeDifference: "20 mins",
          vehicle: CarInfo(brand: "Honda", model: "Civic", patent: '123456', color: 'red', nroGreenCard: '1234', seats: 5, year: 2023),
          createdAt: DateTime.parse("2024-06-14T12:00:00Z"),
          updatedAt: DateTime.parse("2024-06-14T12:00:00Z"),
          compensation: 1000.0,
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: "12 km", value: 12000),
            duration: Distance(text: "20 mins", value: 1200),
            status: "OK",
          ),
        ),
        TripDetail(
          id: 3,
          idDriver: 103,
          pickupNeighborhood: 'Centro',
          pickupText: "321 Maple St",
          pickupLat: 37.7649,
          pickupLng: -122.4094,
          destinationNeighborhood: 'Campus Universitario',
          destinationText: "654 Cedar St",
          destinationLat: 37.7749,
          destinationLng: -122.3994,
          availableSeats: 4,
          departureTime: "2024-06-15T10:00:00Z",
          // pickupPosition: Position(x: 37.7649, y: -122.4094),
          // destinationPosition: Position(x: 37.7749, y: -122.3994),
          distance: 8.0,
          timeDifference: "10 mins",
          vehicle: CarInfo(brand: "Ford", model: "Focus", patent: '123456', color: 'red', nroGreenCard: '1234', seats: 5, year: 2025),
          createdAt: DateTime.parse("2024-06-14T12:00:00Z"),
          updatedAt: DateTime.parse("2024-06-14T12:00:00Z"),
          compensation: 1000.0,
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: "8 km", value: 8000),
            duration: Distance(text: "10 mins", value: 600),
            status: "OK",
          ),
        ),
      ];

      emit(state.copyWith(
        testingArrayTrips: toTripsAvailable,
      ));
    }

    on<GetNearbyTripRequest>((event, emit) async {
      // AuthResponse authResponse = await authUseCases.getUserSession.run();
      // Resource driverPositionResponse = await driversPositionUseCases.getDriverPosition.run(authResponse.user.id ?? 1);

      // emit(
      //   state.copyWith(
      //     response: Loading(),
      //   )
      // );

      // if (driverPositionResponse is Success) {
      //   final driverPosition = driverPositionResponse.data as DriverPosition;
      //   Resource<List<PassengerRequest>> response = await passengerRequestsUseCases.getNearbyTripRequestUseCase.run(driverPosition.lat, driverPosition.lng);
      //   emit(
      //     state.copyWith(
      //       response: response,
      //     )
      //   );
      // }

      // DELETE - Testeando con un objeto de prueba
      print('Usando el Array de prueba');
      _setTestPassengerRequests(event, emit);

    });

  }

}
