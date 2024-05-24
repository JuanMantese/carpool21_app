
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class PassengerMapBookingInfoEvent {}

class PassengerMapBookingInfoInitEvent extends PassengerMapBookingInfoEvent {
  // Cambiando los valores a las variables
  final LatLng pickUpLatLng;
  final String pickUpText;
  final LatLng destinationLatLng;
  final String destinationText;
  
  PassengerMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpText,
    required this.destinationText,
  });
}

// Permite cambiar la posicion de la camara del mapa
class ChangeMapCameraPosition extends PassengerMapBookingInfoEvent {
  final double lat; // Latitud
  final double lng; // Longitud

  ChangeMapCameraPosition({
    required this.lat,
    required this.lng,
  });
}

// Agregando la ruta al mapa
class AddPolyline extends PassengerMapBookingInfoEvent {}

// class FareOfferedChanged extends PassengerMapBookingInfoEvent {
//   final BlocFormItem fareOffered;

//   FareOfferedChanged({required this.fareOffered});
// }


// class CreateClientRequest extends PassengerMapBookingInfoEvent {}
// class GetTimeAndDistanceValues extends PassengerMapBookingInfoEvent {}
// class EmitNewPassengerRequestSocketIO extends PassengerMapBookingInfoEvent {
//   final int idPassengerRequest;
//   EmitNewPassengerRequestSocketIO({required this.idPassengerRequest}); 
// }

