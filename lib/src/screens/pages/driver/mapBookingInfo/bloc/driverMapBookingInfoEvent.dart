
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class DriverMapBookingInfoEvent {}

class DriverMapBookingInfoInitEvent extends DriverMapBookingInfoEvent {
  // Cambiando los valores a las variables
  final LatLng pickUpLatLng;
  final String pickUpText;
  final LatLng destinationLatLng;
  final String destinationText;
  
  DriverMapBookingInfoInitEvent({
    required this.pickUpLatLng,
    required this.destinationLatLng,
    required this.pickUpText,
    required this.destinationText,
  });
}

// Permite cambiar la posicion de la camara del mapa para colocarla sobre la ruta
class ChangeMapCameraPosition extends DriverMapBookingInfoEvent {
  final LatLng pickUpLatLng;
  final LatLng destinationLatLng;

  ChangeMapCameraPosition({
    required this.pickUpLatLng,
    required this.destinationLatLng,
  });
}

// Agregando la ruta al mapa
class AddPolyline extends DriverMapBookingInfoEvent {}

// Trayendo los datos: Teimpo estimado del trayecto y Distancia del punto de origen al punto de destino
class GetTimeAndDistanceValues extends DriverMapBookingInfoEvent {}

// class FareOfferedChanged extends DriverMapBookingInfoEvent {
//   final BlocFormItem fareOffered;

//   FareOfferedChanged({required this.fareOffered});
// }


// class CreateClientRequest extends DriverMapBookingInfoEvent {}
// class EmitNewDriverRequestSocketIO extends DriverMapBookingInfoEvent {
//   final int idDriverRequest;
//   EmitNewDriverRequestSocketIO({required this.idDriverRequest}); 
// }

