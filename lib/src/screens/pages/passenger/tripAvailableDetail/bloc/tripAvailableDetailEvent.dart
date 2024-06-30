
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class TripAvailableDetailEvent {}

class TripAvailableDetailInitEvent extends TripAvailableDetailEvent {
  // Cambiando los valores a las variables
  final String pickUpText;
  final LatLng pickUpLatLng;
  final String destinationText;
  final LatLng destinationLatLng;
  final String departureTime;
  
  TripAvailableDetailInitEvent({
    required this.pickUpText,
    required this.pickUpLatLng,
    required this.destinationText,
    required this.destinationLatLng,
    required this.departureTime,
  });
}

// Permite cambiar la posicion de la camara del mapa para colocarla sobre la ruta
class ChangeMapCameraPosition extends TripAvailableDetailEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;

  ChangeMapCameraPosition({
    required this.pickUpLatLng,
    required this.destinationLatLng,
  });
}

// Agregando la ruta al mapa
class AddPolyline extends TripAvailableDetailEvent {}

// Trayendo los datos: Teimpo estimado del trayecto y Distancia del punto de origen al punto de destino
class GetTimeAndDistanceValues extends TripAvailableDetailEvent {}