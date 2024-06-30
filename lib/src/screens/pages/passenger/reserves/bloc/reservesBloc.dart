

import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/models/reservesAll.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/useCases/reserves/reserveUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReservesBloc extends Bloc<ReservesEvent, ReservesState> {


  ReserveUseCases reserveUseCases;

  ReservesBloc(
    this.reserveUseCases,
  ): super(const ReservesState()) {

  void _setTestReserves(GetReservesAll event, Emitter<ReservesState> emit) {
    final ReservesAll exampleReservesAll = ReservesAll(
      currentReserve: TripDetail(
        id: 1,
        idDriver: 1,
        driver: Driver(
          name: 'Carlos',
          lastName: 'Perez',
          phone: '1234567890',
          photoUser: 'https://example.com/photo.jpg',
        ),
        pickupNeighborhood: 'Centro',
        pickupText: '789 Oak St',
        pickupLat: 37.7749,
        pickupLng: -122.4294,
        destinationNeighborhood: 'Campus Universitario',
        destinationText: '123 Pine St',
        destinationLat: 37.7949,
        destinationLng: -122.4194,
        availableSeats: 2,
        departureTime: '2024-06-15T18:30:00Z',
        distance: 12.0,
        timeDifference: '20 mins',
        compensation: 25.0,
        vehicle: CarInfo(
          brand: 'Honda',
          model: 'Civic',
          patent: '123456',
          color: 'red',
          nroGreenCard: '1234',
          seats: 5,
          year: 2023,
        ),
        createdAt: DateTime.parse('2024-06-14T12:00:00Z'),
        updatedAt: DateTime.parse('2024-06-14T12:00:00Z'),
        googleDistanceMatrix: GoogleDistanceMatrix(
          distance: Distance(text: '12 km', value: 12000),
          duration: Distance(text: '20 mins', value: 1200),
          status: 'OK',
        ),
        observations: 'Encuentro en el Patio Olmos sobre la puerta de entrada que da a Bvd Illia',
        reserves: [
          Reserve(
            idTrip: 1,
            idPassenger: 1,
            name: 'Franco Jose',
            lastName: 'Jara',
          ),
          Reserve(
            idTrip: 1,
            idPassenger: 2,
            name: 'Franco',
            lastName: 'Apostoli',
          ),
        ],
      ),
      futureReserves: [
        TripDetail(
          id: 2,
          idDriver: 2,
          driver: Driver(
            name: 'Ana',
            lastName: 'Gomez',
            phone: '0987654321',
            photoUser: 'https://example.com/photo2.jpg',
          ),
          pickupNeighborhood: 'Norte',
          pickupText: '456 Maple St',
          pickupLat: 37.8049,
          pickupLng: -122.4094,
          destinationNeighborhood: 'Estadio',
          destinationText: '456 Elm St',
          destinationLat: 37.8149,
          destinationLng: -122.3994,
          availableSeats: 3,
          departureTime: '2024-06-15T19:00:00Z',
          distance: 15.0,
          timeDifference: '25 mins',
          compensation: 30.0,
          vehicle: CarInfo(
            brand: 'Toyota',
            model: 'Corolla',
            patent: '654321',
            color: 'blue',
            nroGreenCard: '5678',
            seats: 4,
            year: 2022,
          ),
          createdAt: DateTime.parse('2024-06-15T14:00:00Z'),
          updatedAt: DateTime.parse('2024-06-15T14:00:00Z'),
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: '15 km', value: 15000),
            duration: Distance(text: '25 mins', value: 1500),
            status: 'OK',
          ),
          observations: 'Encuentro en la entrada principal del estadio',
          reserves: [
            Reserve(
              idTrip: 2,
              idPassenger: 3,
              name: 'María',
              lastName: 'Fernandez',
            ),
          ],
        ),
        TripDetail(
          id: 2,
          idDriver: 2,
          driver: Driver(
            name: 'Ana',
            lastName: 'Gomez',
            phone: '0987654321',
            photoUser: 'https://example.com/photo2.jpg',
          ),
          pickupNeighborhood: 'Norte',
          pickupText: '456 Maple St',
          pickupLat: 37.8049,
          pickupLng: -122.4094,
          destinationNeighborhood: 'Estadio',
          destinationText: '456 Elm St',
          destinationLat: 37.8149,
          destinationLng: -122.3994,
          availableSeats: 3,
          departureTime: '2024-06-15T19:00:00Z',
          distance: 15.0,
          timeDifference: '25 mins',
          compensation: 30.0,
          vehicle: CarInfo(
            brand: 'Toyota',
            model: 'Corolla',
            patent: '654321',
            color: 'blue',
            nroGreenCard: '5678',
            seats: 4,
            year: 2022,
          ),
          createdAt: DateTime.parse('2024-06-15T14:00:00Z'),
          updatedAt: DateTime.parse('2024-06-15T14:00:00Z'),
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: '15 km', value: 15000),
            duration: Distance(text: '25 mins', value: 1500),
            status: 'OK',
          ),
          observations: 'Encuentro en la entrada principal del estadio',
          reserves: [
            Reserve(
              idTrip: 2,
              idPassenger: 3,
              name: 'María',
              lastName: 'Fernandez',
            ),
          ],
        ),
        TripDetail(
          id: 2,
          idDriver: 2,
          driver: Driver(
            name: 'Ana',
            lastName: 'Gomez',
            phone: '0987654321',
            photoUser: 'https://example.com/photo2.jpg',
          ),
          pickupNeighborhood: 'Norte',
          pickupText: '456 Maple St',
          pickupLat: 37.8049,
          pickupLng: -122.4094,
          destinationNeighborhood: 'Estadio',
          destinationText: '456 Elm St',
          destinationLat: 37.8149,
          destinationLng: -122.3994,
          availableSeats: 3,
          departureTime: '2024-06-15T19:00:00Z',
          distance: 15.0,
          timeDifference: '25 mins',
          compensation: 30.0,
          vehicle: CarInfo(
            brand: 'Toyota',
            model: 'Corolla',
            patent: '654321',
            color: 'blue',
            nroGreenCard: '5678',
            seats: 4,
            year: 2022,
          ),
          createdAt: DateTime.parse('2024-06-15T14:00:00Z'),
          updatedAt: DateTime.parse('2024-06-15T14:00:00Z'),
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: '15 km', value: 15000),
            duration: Distance(text: '25 mins', value: 1500),
            status: 'OK',
          ),
          observations: 'Encuentro en la entrada principal del estadio',
          reserves: [
            Reserve(
              idTrip: 2,
              idPassenger: 3,
              name: 'María',
              lastName: 'Fernandez',
            ),
          ],
        ),
        TripDetail(
          id: 2,
          idDriver: 2,
          driver: Driver(
            name: 'Ana',
            lastName: 'Gomez',
            phone: '0987654321',
            photoUser: 'https://example.com/photo2.jpg',
          ),
          pickupNeighborhood: 'Norte',
          pickupText: '456 Maple St',
          pickupLat: 37.8049,
          pickupLng: -122.4094,
          destinationNeighborhood: 'Estadio',
          destinationText: '456 Elm St',
          destinationLat: 37.8149,
          destinationLng: -122.3994,
          availableSeats: 3,
          departureTime: '2024-06-15T19:00:00Z',
          distance: 15.0,
          timeDifference: '25 mins',
          compensation: 30.0,
          vehicle: CarInfo(
            brand: 'Toyota',
            model: 'Corolla',
            patent: '654321',
            color: 'blue',
            nroGreenCard: '5678',
            seats: 4,
            year: 2022,
          ),
          createdAt: DateTime.parse('2024-06-15T14:00:00Z'),
          updatedAt: DateTime.parse('2024-06-15T14:00:00Z'),
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: '15 km', value: 15000),
            duration: Distance(text: '25 mins', value: 1500),
            status: 'OK',
          ),
          observations: 'Encuentro en la entrada principal del estadio',
          reserves: [
            Reserve(
              idTrip: 2,
              idPassenger: 3,
              name: 'María',
              lastName: 'Fernandez',
            ),
          ],
        ),
      ],
      historicalReserves: [
        TripDetail(
          id: 3,
          idDriver: 3,
          driver: Driver(
            name: 'Luis',
            lastName: 'Martinez',
            phone: '1122334455',
            photoUser: 'https://example.com/photo3.jpg',
          ),
          pickupNeighborhood: 'Sur',
          pickupText: '321 Birch St',
          pickupLat: 37.7849,
          pickupLng: -122.4394,
          destinationNeighborhood: 'Parque',
          destinationText: '789 Cedar St',
          destinationLat: 37.7549,
          destinationLng: -122.4694,
          availableSeats: 1,
          departureTime: '2024-06-15T17:00:00Z',
          distance: 10.0,
          timeDifference: '15 mins',
          compensation: 20.0,
          vehicle: CarInfo(
            brand: 'Ford',
            model: 'Focus',
            patent: '789012',
            color: 'green',
            nroGreenCard: '91011',
            seats: 5,
            year: 2021,
          ),
          createdAt: DateTime.parse('2024-06-13T16:00:00Z'),
          updatedAt: DateTime.parse('2024-06-13T16:00:00Z'),
          googleDistanceMatrix: GoogleDistanceMatrix(
            distance: Distance(text: '10 km', value: 10000),
            duration: Distance(text: '15 mins', value: 900),
            status: 'OK',
          ),
          observations: 'Encuentro en la entrada del parque',
          reserves: [
            Reserve(
              idTrip: 3,
              idPassenger: 4,
              name: 'Juan',
              lastName: 'Perez',
            ),
          ],
        ),
      ],
    );

    emit(state.copyWith(
      testingReservesAll: exampleReservesAll,
    ));

 }
    

    on<GetReservesAll>((event, emit) async {
      print('GetReservesAll');

      emit(
        state.copyWith(
          response: Loading(),
        )
      );
      // Recuperando las reservas del Pasajero
      // Resource<ReservesAll> response = await reserveUseCases.getAllReservesUseCase.run();
      // print('Response - $response');
      // emit(
      //   state.copyWith(
      //     response: response,
      //   )
      // );

      // DELETE - Testeando con un objeto de prueba
      print('Usando el Array de prueba');
      _setTestReserves(event, emit);
    }); 

  }
}
