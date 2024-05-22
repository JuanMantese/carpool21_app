import 'package:carpool_21_app/src/domain/models/placemarkData.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class GeolocationRepository {

  // Obteniendo posicion del usuario
  Future<Position> findPosition();

  // Agregando marcadores al mapa
  Future<BitmapDescriptor> createMarkerFromAsset(String path);
  
  Marker getMarker( // Marcador
    String markerId,
    double lat, 
    double lng,
    String title,
    String content,
    BitmapDescriptor imageMarker 
  );
  
  // Tomando ubicacion del marker al mover la camara 
  Future<PlacemarkData?> getPlacemarkData(CameraPosition cameraPosition);
  
  // Future<List<LatLng>> getPolyline(LatLng pickUpLatLng, LatLng destinationLatLng);
  
  // Stream<Position> getPositionStream();
}