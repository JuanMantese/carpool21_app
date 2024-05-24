
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PassengerMapFinderEvent {}

class PassengerMapFinderInitEvent extends PassengerMapFinderEvent {}

class FindPosition extends PassengerMapFinderEvent {}

// Permite cambiar la posicion de la camara del mapa
class ChangeMapCameraPosition extends PassengerMapFinderEvent {
  final double lat; // Latitud
  final double lng; // Longitud

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

// Obteniendo ubicacion del marker en el mapa al mover la camara
class OnCameraMove extends PassengerMapFinderEvent {
  CameraPosition cameraPosition;
  OnCameraMove({required this.cameraPosition});
}

class OnCameraIdle extends PassengerMapFinderEvent {}

// El evento se dispara cuando el usuario elije un lugar de Origen
class OnAutoCompletedPickUpSelected extends PassengerMapFinderEvent {
  double lat;
  double lng;
  String pickUpText;
  OnAutoCompletedPickUpSelected({required this.lat, required this.lng, required this.pickUpText});
}

// El evento se dispara cuando el usuario elije un lugar de Origen
class OnAutoCompletedDestinationSelected extends PassengerMapFinderEvent {
  double lat;
  double lng;
  String destinationText;
  OnAutoCompletedDestinationSelected({required this.lat, required this.lng, required this.destinationText});
}

// class ListenDriversPositionSocketIO extends PassengerMapFinderEvent {}
// class ListenDriversDisconnectedSocketIO extends PassengerMapFinderEvent {}
// class RemoveDriverPositionMarker extends PassengerMapFinderEvent {
//   final String idSocket;

//   RemoveDriverPositionMarker({ required this.idSocket });
// }
// class AddDriverPositionMarker extends PassengerMapFinderEvent {

//   final String idSocket;
//   final int id;
//   final double lat;
//   final double lng;

//   AddDriverPositionMarker({
//     required this.idSocket,
//     required this.id,
//     required this.lat,
//     required this.lng,
//   });

// }