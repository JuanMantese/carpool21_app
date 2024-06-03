import 'dart:async';
import 'package:carpool_21_app/src/domain/models/placemarkData.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapFinderState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final Position? position;
  final Map<MarkerId, Marker> markers; // Manejador de estados de los marcadores
  final CameraPosition cameraPosition; // Posicion de la camara en el mapa
  final PlacemarkData? placemarkData; // Marcador en el mapa segun posicion de la camara
  final LatLng? pickUpLatLng; // Variable para pasar los datos (Lat y Lng) de origen
  final LatLng? destinationLatLng; // Variable para pasar los datos (Lat y Lng) de destino
  final String pickUpText; // Variable para pasar el texto del input del origen
  final String destinationText; // Variable para pasar el texto del input del destino

  final Map<PolylineId, Polyline> polylines;

  // Constructor 
  PassengerMapFinderState({
    this.controller,
    this.position,
    this.markers = const <MarkerId, Marker>{},
    this.cameraPosition = const CameraPosition(target: LatLng(-31.322187, -64.2219203), zoom: 15.0),
    this.placemarkData,
    this.pickUpLatLng,
    this.destinationLatLng,
    this.pickUpText = '',
    this.destinationText = '',

    this.polylines = const <PolylineId, Polyline>{},
  });

  // CopuWith - Nos permite cambiamos el estado de las variables
  PassengerMapFinderState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    Map<MarkerId, Marker>? markers,
    CameraPosition? cameraPosition,
    PlacemarkData? placemarkData,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpText,
    String? destinationText,

    Map<PolylineId, Polyline>? polylines,
  }) {
    
    return PassengerMapFinderState(
      controller: controller ?? this.controller,
      position: position ?? this.position,
      markers: markers ?? this.markers,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      placemarkData: placemarkData ?? this.placemarkData,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpText: pickUpText ?? this.pickUpText,
      destinationText: destinationText ?? this.destinationText,

      polylines: polylines ?? this.polylines,
    );
  }


  @override
  List<Object?> get props => [controller, position, markers, cameraPosition, placemarkData, pickUpLatLng, destinationLatLng, pickUpText, destinationText, polylines];

}