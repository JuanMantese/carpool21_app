import 'dart:async';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripAvailableDetailState extends Equatable {

  final Completer<GoogleMapController>? controller;
  final Position? position;
  final CameraPosition cameraPosition;
  final Map<MarkerId, Marker> markers;
  final String pickUpText;
  final LatLng? pickUpLatLng;
  final String destinationText;
  final LatLng? destinationLatLng;
  final String? departureTime;
  final Map<PolylineId, Polyline> polylines; // Permite trazar la ruta origen/destino
  final LatLngBounds? routeBounds; // Recuadro que se crea para envolver los limites de la ruta (Polyline)
  final Resource? responseTimeAndDistance;
  // final Resource? responseClientRequest;
  // final BlocFormItem fareOffered;
  

  TripAvailableDetailState({
    this.controller,
    this.position,
    this.cameraPosition = const CameraPosition(target: LatLng(-31.3992803, -64.2766129), zoom: 13.0),
    this.markers = const <MarkerId, Marker>{},
    this.pickUpText = '',
    this.pickUpLatLng,
    this.destinationText = '',
    this.destinationLatLng,
    this.departureTime,
    this.polylines = const <PolylineId, Polyline>{},
    this.routeBounds,
    this.responseTimeAndDistance,
    // this.responseClientRequest,
    // this.fareOffered = const BlocFormItem(error: 'Ingresa la tarifa')
  });

  TripAvailableDetailState copyWith({
    Completer<GoogleMapController>? controller,
    Position? position,
    CameraPosition? cameraPosition,
    Map<MarkerId, Marker>? markers,
    String? pickUpText,
    LatLng? pickUpLatLng,
    String? destinationText,
    LatLng? destinationLatLng,
    String? departureTime,
    Map<PolylineId, Polyline>? polylines,
    LatLngBounds? routeBounds,
    Resource? responseTimeAndDistance,
    // Resource? responseClientRequest,
    // BlocFormItem? fareOffered
  }) {
    return TripAvailableDetailState(
      controller: controller ?? this.controller,
      position: position ?? this.position,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      markers: markers ?? this.markers,
      pickUpText: pickUpText ?? this.pickUpText,
      pickUpLatLng: pickUpLatLng ?? this.pickUpLatLng,
      destinationText: destinationText ?? this.destinationText,
      destinationLatLng: destinationLatLng ?? this.destinationLatLng,
      departureTime: departureTime ?? this.departureTime,
      polylines: polylines ?? this.polylines,
      routeBounds: routeBounds ?? this.routeBounds,
      responseTimeAndDistance: responseTimeAndDistance ?? this.responseTimeAndDistance,
      // responseClientRequest: responseClientRequest,
      // fareOffered: fareOffered ?? this.fareOffered
    );
  }


  @override
  // DESCOMENTAR List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText, responseTimeAndDistance, responseClientRequest, fareOffered];
  List<Object?> get props => [position, markers, polylines, controller, cameraPosition, pickUpLatLng, destinationLatLng, pickUpText, destinationText, departureTime, responseTimeAndDistance, routeBounds];

}