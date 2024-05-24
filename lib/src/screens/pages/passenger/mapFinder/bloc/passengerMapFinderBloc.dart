import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:carpool_21_app/src/domain/models/placemarkData.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapFinderBloc extends Bloc<PassengerMapFinderEvent, PassengerMapFinderState> {

  GeolocationUseCases geolocationUseCases;
  // SocketUseCases socketUseCases;
  // BlocSocketIO blocSocketIO;
  

  PassengerMapFinderBloc(this.geolocationUseCases): super(PassengerMapFinderState()) {
    
    on<PassengerMapFinderInitEvent>((event, emit) {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();
      emit(
        state.copyWith(
          controller: controller
        )
      );
    });

    on<FindPosition>((event, emit) async {
      // User Position
      Position position = await geolocationUseCases.findPosition.run();
      
      // Modificando la posicion de la camara en el mapa
      add(ChangeMapCameraPosition(lat: position.latitude, lng: position.longitude));

      // REVISAR SI SE ESTA USANDO - Porque anadi la funcionalidad de que el marcador se muestre en movimiento
      // Trayendo la imagen del marker
      BitmapDescriptor imageMarker = await geolocationUseCases.createMarker.run('lib/assets/img/map-maker-green.png');

      // Actualizando estado de los marcadores
      Marker marker = geolocationUseCases.getMarker.run(
        'MyLocation',
        position.latitude,
        position.longitude,
        'Mi Possicion',
        '',
        imageMarker
      );
      // ------------------------------------------------

      // Agregando el marcador al mapa
      emit(
        state.copyWith(
          position: position, // Change Position State
          markers: {
            marker.markerId: marker // Adding Marker
          },
        )
      );

      print('Position Lat: ${position.latitude}');
      print('Position Lng: ${position.longitude}');
    });

    // Ajustando la posicion de la camara (y el marker) en el mapa segun la posicion que el usuario elijio
    // El usuario puede elegir la posicion desde el input o moviendo el marker con la camara
    on<ChangeMapCameraPosition>((event, emit) async {
      try {
        GoogleMapController googleMapController = await state.controller!.future;
        
        await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
          CameraPosition(
            target: LatLng(event.lat, event.lng),
            zoom: 13,
            bearing: 0
          )
        ));
      } catch (e) {
        print('ERROR EN ChangeMapCameraPosition: $e');
      }
    });  

    // Obteniendo ubicacion del marker en el mapa al mover la camara
    on<OnCameraMove>((event, emit) {
      emit(
        state.copyWith(
          cameraPosition: event.cameraPosition
        )
      );
    });

    // Al terminar de mover la camara, fijo el marcador en la posicion donde esta se encuentra
    // Estableciendo la direccion la que el marker esta ubicado
    on<OnCameraIdle>((event, emit) async {
      try {
        PlacemarkData placemarkData = await geolocationUseCases.getPlacemarkData.run(state.cameraPosition);
        emit(
          state.copyWith(
            placemarkData: placemarkData
          )
        );  
      } catch (e) {
        print('OnCameraIdle Error: $e');
      }
    });

    // Enviando los datos de Origen a otra pantalla
    on<OnAutoCompletedPickUpSelected>((event, emit) {
      emit(
        state.copyWith(
          pickUpLatLng: LatLng(event.lat, event.lng),
          pickUpText: event.pickUpText
        )
      );
    });

    // Enviando los datos de Destino a otra pantalla
    on<OnAutoCompletedDestinationSelected>((event, emit) {
      emit(
        state.copyWith(
          destinationLatLng: LatLng(event.lat, event.lng),
          destinationText: event.destinationText
        )
      );
    });


    // on<ListenDriversPositionSocketIO>((event, emit) async {
    //   if (blocSocketIO.state.socket != null ) {
    //     blocSocketIO.state.socket?.on('new_driver_position', (data) {
    //       add(
    //         AddDriverPositionMarker(
    //           idSocket: data['id_socket'] as String, 
    //           id: data['id'] as int, 
    //           lat: data['lat'] as double, 
    //           lng: data['lng'] as double
    //         )
    //       );
    //     });
    //   }
    // });

    // on<ListenDriversDisconnectedSocketIO>((event, emit) {
    //   if (blocSocketIO.state.socket != null ) {
    //     blocSocketIO.state.socket?.on('driver_disconnected', (data) {
    //       print('Id: ${data['id_socket']}');
    //       add(RemoveDriverPositionMarker(idSocket: data['id_socket'] as String));
    //     });
    //   }
    // });

    // on<RemoveDriverPositionMarker>((event, emit) {
    //   emit(
    //       state.copyWith(
    //         markers: Map.of(state.markers)..remove(MarkerId(event.idSocket))
    //       )
    //     );
    // });

    // on<AddDriverPositionMarker>((event, emit) async {
    //   BitmapDescriptor descriptor = await geolocatorUseCases.createMarker.run('assets/img/car_pin.png');
    //   Marker marker = geolocatorUseCases.getMarker.run(
    //     event.idSocket,
    //     event.lat,
    //     event.lng,
    //     'Conductor disponible',
    //     '',
    //     descriptor
    //   );
    //   emit(
    //     state.copyWith(
    //       markers: Map.of(state.markers)..[marker.markerId] = marker
    //     )
    //   );
    // });

  }

}