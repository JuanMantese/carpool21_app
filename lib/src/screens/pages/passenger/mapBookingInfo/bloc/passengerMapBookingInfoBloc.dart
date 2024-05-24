import 'dart:async';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class PassengerMapBookingInfoBloc extends Bloc<PassengerMapBookingInfoEvent, PassengerMapBookingInfoState> {

  GeolocationUseCases geolocationUseCases;
  // PassengerRequestsUseCases passengerRequestsUseCases;
  // AuthUseCases authUseCases;
  // BlocSocketIO blocSocketIO;
  

  // DESCOMENTAR
  // PassengerMapBookingInfoBloc(this.blocSocketIO, this.geolocationUseCases, this.passengerRequestsUseCases, this.authUseCases): super(PassengerMapBookingInfoState()) {
  PassengerMapBookingInfoBloc(this.geolocationUseCases): super(PassengerMapBookingInfoState()) {
  
    on<PassengerMapBookingInfoInitEvent>((event, emit) async {
      Completer<GoogleMapController> controller = Completer<GoogleMapController>();

      emit(
        state.copyWith(
          pickUpLatLng: event.pickUpLatLng,
          pickUpText: event.pickUpText,
          destinationLatLng: event.destinationLatLng,
          destinationText: event.destinationText,
          controller: controller,
        )
      );

      // Defino los Markers aca para que primero se inicialicen las posiciones
      // Trayendo las imagenes de los marker que coloco en el mapa al trazar la ruta
      BitmapDescriptor pickUpMarkerImg = await geolocationUseCases.createMarker.run('lib/assets/img/map-maker-green.png');
      BitmapDescriptor destinationMarkerImg = await geolocationUseCases.createMarker.run('lib/assets/img/map-maker-green.png');

      // Actualizando estado de los marcadores
      Marker markerPickUp = geolocationUseCases.getMarker.run(
        'MyLocation',
        state.pickUpLatLng!.latitude,
        state.pickUpLatLng!.longitude,
        'Lugar de Origen',
        '',
        pickUpMarkerImg
      );

      Marker markerDestination = geolocationUseCases.getMarker.run(
        'MyLocation',
        state.destinationLatLng!.latitude,
        state.destinationLatLng!.longitude,
        'Lugar de Destino',
        '',
        destinationMarkerImg
      );

      emit(
        state.copyWith(
          markers: {
            markerPickUp.markerId: markerPickUp,
            markerDestination.markerId: markerDestination,
          }
        )
      );
    });

    on<ChangeMapCameraPosition>((event, emit) async {
      GoogleMapController googleMapController = await state.controller!.future;
      await googleMapController.animateCamera(CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(event.lat, event.lng),
          zoom: 12,
          bearing: 0
        )
      ));
    });

    // Agregando la ruta al mapa
    on<AddPolyline>((event, emit) async {
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
    });

    // on<FareOfferedChanged>((event, emit) {
    //   emit(
    //     state.copyWith(fareOffered: BlocFormItem(
    //       value: event.fareOffered.value,
    //       error: event.fareOffered.value.isEmpty ? 'Ingresa la tarifa' : null
    //     ))
    //   );
    // });

    // on<CreatePassengerRequest>((event, emit) async {
    //   AuthResponse authResponse = await authUseCases.getUserSession.run();

    //   Resource<int> response = await passengerRequestsUseCases.createPassengerRequest.run(
    //     PassengerRequest(
    //       idClient: authResponse.user.id!, 
    //       fareOffered: double.parse(state.fareOffered.value), 
    //       pickupDescription: state.pickUpDescription, 
    //       destinationDescription: state.destinationDescription, 
    //       pickupLat: state.pickUpLatLng!.latitude, 
    //       pickupLng: state.pickUpLatLng!.longitude, 
    //       destinationLat: state.destinationLatLng!.latitude, 
    //       destinationLng: state.destinationLatLng!.longitude
    //     )
    //   );

    //   emit(
    //     state.copyWith(
    //       responsePassengerRequest: response
    //     )
    //   );
    // });

    // on<EmitNewPassengerRequestSocketIO>((event, emit) {
    //   if (blocSocketIO.state.socket != null) {
    //     blocSocketIO.state.socket?.emit('new_client_request', {
    //         'id_client_request': event.idClientRequest
    //     });
    //   }
    // });

    // on<GetTimeAndDistanceValues>((event, emit) async {
    //   emit(
    //     state.copyWith(
    //       responseTimeAndDistance: Loading()
    //     )
    //   );
    //   Resource<TimeAndDistanceValues> response = await clientRequestsUseCases.getTimeAndDistance.run(
    //     state.pickUpLatLng!.latitude,
    //     state.pickUpLatLng!.longitude,
    //     state.destinationLatLng!.latitude,
    //     state.destinationLatLng!.longitude,
    //   );
    //   emit(
    //     state.copyWith(
    //       responseTimeAndDistance: response
    //     )
    //   );
    // });

  }
}