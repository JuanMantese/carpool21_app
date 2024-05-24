import 'dart:async';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapBookingInfoState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final Map<PolylineId, Polyline> polylines; // Permite trazar la ruta origen/destino
  final LatLng? pickUpLatLng;
  final String pickUpText;
  final LatLng? destinationLatLng;
  final String destinationText;
  final Position? position;
  // final Resource? responseTimeAndDistance;
  // final Resource? responseClientRequest;
  // final BlocFormItem fareOffered;
  

  PassengerMapBookingInfoState({
    this.controller,
    this.cameraPosition = const CameraPosition(target: LatLng(4.7449125, -74.1113708), zoom: 14.0),
    this.position,
    this.pickUpLatLng,
    this.pickUpText = '',
    this.destinationLatLng,
    this.destinationText = '',
    this.markers = const <MarkerId, Marker>{},
    this.polylines = const <PolylineId, Polyline>{},
    // this.responseTimeAndDistance,
    // this.responseClientRequest,
    // this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa')
  });

  PassengerMapBookingInfoState copyWith({
    Position? position,
    Completer<GoogleMapController>? controller,
    CameraPosition? cameraPosition,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpText,
    String? destinationText,
    Map<MarkerId, Marker>? markers,
    Map<PolylineId, Polyline>? polylines,
    // Resource? responseTimeAndDistance,
    // Resource? responseClientRequest,
    // BlocFormItem? fareOffered
  }) {
    return PassengerMapBookingInfoState(
      position: position ?? this.position,
      markers: markers ?? this.markers,
      polylines: polylines ?? this.polylines,
      controller: controller ?? this.controller,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpText: pickUpText ?? this.pickUpText,
      destinationText: destinationText ?? this.destinationText,
      // responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,
      // responseClientRequest: responseClientRequest,
      // fareOffered: fareOffered ?? this.fareOffered
    );
  }


  @override
  // List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText, responseTimeAndDistance, responseClientRequest, fareOffered];
  List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText];

}