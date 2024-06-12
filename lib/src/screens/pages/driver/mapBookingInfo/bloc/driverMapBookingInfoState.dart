import 'dart:async';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapBookingInfoState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final LatLng? pickUpLatLng;
  final String pickUpText;
  final LatLng? destinationLatLng;
  final String destinationText;
  final Map<PolylineId, Polyline> polylines; // Permite trazar la ruta origen/destino
  final LatLngBounds? routeBounds; // Recuadro que se crea para envolver los limites de la ruta (Polyline)
  final Resource? responseTimeAndDistance;
  // final Resource? responseClientRequest;
  // final BlocFormItem fareOffered;
  

  DriverMapBookingInfoState({
    this.controller,
    this.position,
    this.cameraPosition = const CameraPosition(target: LatLng(-31.3992803, -64.2766129), zoom: 13.0),
    this.markers = const <MarkerId, Marker>{},
    this.pickUpLatLng,
    this.pickUpText = '',
    this.destinationLatLng,
    this.destinationText = '',
    this.polylines = const <PolylineId, Polyline>{},
    this.routeBounds,
    this.responseTimeAndDistance,
    // this.responseClientRequest,
    // this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa')
  });

  DriverMapBookingInfoState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    LatLng? pickUpLatLng,
    LatLng? destinationLatLng,
    String? pickUpText,
    String? destinationText,
    Map<PolylineId, Polyline>? polylines,
    LatLngBounds? routeBounds,
    Resource? responseTimeAndDistance,
    // Resource? responseClientRequest,
    // BlocFormItem? fareOffered
  }) {
    return DriverMapBookingInfoState(
      controller: controller ?? this.controller,
      position: position ?? this.position,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      markers: markers ?? this.markers,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      pickUpText: pickUpText ?? this.pickUpText,
      destinationText: destinationText ?? this.destinationText,
      polylines: polylines ?? this.polylines,
      routeBounds: routeBounds ?? this.routeBounds,
      responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,
      // responseClientRequest: responseClientRequest,
      // fareOffered: fareOffered ?? this.fareOffered
    );
  }


  @override
  // DESCOMENTAR List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText, responseTimeAndDistance, responseClientRequest, fareOffered];
  List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText, responseTimeAndDistance, routeBounds];

}