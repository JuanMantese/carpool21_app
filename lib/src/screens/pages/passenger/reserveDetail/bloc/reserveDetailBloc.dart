import 'dart:async';
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/reserve.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/driverTripRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserveDetail/bloc/reserveDetailEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserveDetail/bloc/reserveDetailState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ReserveDetailBloc extends Bloc<ReserveDetailEvent, ReserveDetailState> {

  GeolocationUseCases geolocationUseCases;
  DriverTripRequestsUseCases driverTripRequestsUseCases;

  // Constructor
  ReserveDetailBloc(this.geolocationUseCases, this.driverTripRequestsUseCases): super(ReserveDetailState()) {
    
    void _setTestReserveDetail(GetReserveDetail event, Emitter<ReserveDetailState> emit) {
      final TripDetail testTripDetail = TripDetail(
        id: 1,
        idDriver: 1,
        driver: Driver(
          name: 'Carlos',
          lastName: 'Perez',
          phone: '1234567890',
        ),
        pickupNeighborhood: 'Centro',
        pickupText: "789 Oak St",
        pickupLat: 37.7749,
        pickupLng: -122.4294,
        destinationNeighborhood: 'Campus Universitario',
        destinationText: "123 Pine St",
        destinationLat: 37.7949,
        destinationLng: -122.4194,
        availableSeats: 2,
        departureTime: "18:30",
        distance: 12.0,
        timeDifference: "20 mins",
        vehicle: CarInfo(brand: "Honda", model: "Civic", patent: '123456', color: 'red', nroGreenCard: '1234', seats: 5, year: 2023),
        createdAt: DateTime.parse("2024-06-14T12:00:00Z"),
        updatedAt: DateTime.parse("2024-06-14T12:00:00Z"),
        compensation: 25.0,
        googleDistanceMatrix: GoogleDistanceMatrix(
          distance: Distance(text: "12 km", value: 12000),
          duration: Distance(text: "20 mins", value: 1200),
          status: "OK",
        ),
        observations: 'Encuentro en el Patio Olmos sobre la puerta de entrada que da a Bvd Illia',
        reserves: [
          Reserve(
            idTrip: 1, 
            idPassenger: 1, 
            name: 'Franco Jose', 
            lastName: 'Jara'
          ),
          Reserve(
            idTrip: 1, 
            idPassenger: 2, 
            name: 'Franco', 
            lastName: 'Apostoli'
          ),
        ]
      );

      emit(state.copyWith(
        reserveDetail: testTripDetail,
        pickUpLatLng: LatLng(testTripDetail.pickupLat, testTripDetail.pickupLng),
        destinationLatLng: LatLng(testTripDetail.destinationLat, testTripDetail.destinationLng)
      ));
    }

    on<GetReserveDetail>((event, emit) async {
      // try {
      //   // Realizar la consulta para traer el detalle de un viaje
      //   AuthResponse authResponse = await authUseCases.getUserSession.run();

      //   if (authResponse != null && authResponse.user != null) {
      //     print('Datos del usuario obtenidos');
      //     emit(
      //       state.copyWith(
      //         tripDetail: tripDetailContent,
      //       )
      //     );
      //   } else {
      //     print('AuthResponse es Null');
      //     _setTestTripDetail(event, emit);
      //   }
      // } catch (error) {
      //   print('Error GetTripDetail $error');
      //   _setTestTripDetail(event, emit);
      // }

      print('Usando _setTestReserveDetail');
      _setTestReserveDetail(event, emit);
    }); 

    on<InitializeMap>((event, emit) async {
      print('InitializeMap -------------------------------------');
      print(state.destinationLatLng);

      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      
      // Defino los Markers aca para que primero se inicialicen las posiciones
      // Trayendo las imagenes de los marker que coloco en el mapa al trazar la ruta
      BitmapDescriptor pickUpMarkerImg = await geolocationUseCases.createMarker.run('lib/assets/img/map-marker-small.png');
      BitmapDescriptor destinationMarkerImg = await geolocationUseCases.createMarker.run('lib/assets/img/map-marker-green-small.png');

      // Actualizando estado de los marcadores
      Marker markerPickUp = geolocationUseCases.getMarker.run(
        'originLocation',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de Origen',
        '',
        pickUpMarkerImg
      );

      Marker markerDestination = geolocationUseCases.getMarker.run(
        'destinationLocation',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Lugar de Destino',
        '',
        destinationMarkerImg
      );

      emit(
        state.copyWith(
          controller: controller,
          markers: {
            markerPickUp.markerId: markerPickUp,
            markerDestination.markerId: markerDestination,
          }
        )
      );
    });

    // Ajustando la posicion de la camara en el mapa segun la ruta elegida
    on<ChangeMapCameraPosition>((event, emit) async {
      print('Entramos a ChangeMapCameraPosition  -------------------------------------');
      print(state.controller);
      print(event.pickUpLatLng);
      print(event.destinationLatLng);

      try {
        GoogleMapController googleMapController = await state.controller!.future;

        // Calcula los límites usando pickUpLatLng y destinationLatLng
        LatLngBounds bounds = calculateBounds(event.pickUpLatLng, event.destinationLatLng);

        await googleMapController.animateCamera(CameraUpdate.newLatLngBounds(bounds, 100));
        print('Posicionamiento completado');
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
    });  

    // Agregando la ruta al mapa
    on<AddPolyline>((event, emit) async {
      print('Entrando a AddPolyline  -------------------------------------');
      // Obteniendo las coordenadas del origen y destino
      List<LatLng> polylineCoordinates = await geolocationUseCases.getPolyline.run(state.pickUpLatLng!, state.destinationLatLng!);

      PolylineId id = PolylineId("MyRoute"); // Id de la ruta
      Polyline polyline = Polyline(
        polylineId: id, 
        color: Colors.blueAccent, 
        points: polylineCoordinates, // LatLng Origen/Destino
        width: 6  // Tamaño de la ruta en el mapa
      );
      emit(
        state.copyWith(
          polylines: {
            id: polyline
          }
        )
      );

      // Modificando la posicion de la camara en el mapa
      add(ChangeMapCameraPosition(pickUpLatLng: state.pickUpLatLng!, destinationLatLng: state.destinationLatLng!));
    });
  }

  // Funcion para calcular los limites de la ruta, y poder realizar el movimiento de la camara
  LatLngBounds calculateBounds(LatLng pickUp, LatLng destination) {
    LatLngBounds bounds;

    if (pickUp.latitude > destination.latitude && pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(southwest: destination, northeast: pickUp);
    } else if (pickUp.longitude > destination.longitude) {
      bounds = LatLngBounds(
        southwest: LatLng(pickUp.latitude, destination.longitude),
        northeast: LatLng(destination.latitude, pickUp.longitude));
    } else if (pickUp.latitude > destination.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destination.latitude, pickUp.longitude),
        northeast: LatLng(pickUp.latitude, destination.longitude));
    } else {
      bounds = LatLngBounds(southwest: pickUp, northeast: destination);
    }

    return bounds;
  }
}