import 'package:carpool_21_app/src/data/api/apiKeyGoogle.dart';
import 'package:carpool_21_app/src/domain/models/placemarkData.dart';
import 'package:carpool_21_app/src/domain/repository/geolocationRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';


class GeolocationRepositoryImpl implements GeolocationRepository {
  
  @override
  Future<Position> findPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the 
      // App to enable the location services.
      print('La ubicacion no esta activada');
      return Future.error('Location services are disabled.');
    }

    // Pide los permisos al dispositivo (Usuario)
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print('Permiso no otorgado por el usuario');
        return Future.error('Location permissions are denied');
      }
    }
    
    // Verifica si los permisos fueron denegados permanentemente
    if (permission == LocationPermission.deniedForever) {
      print('Permiso no otorgado por el usuario permanentemente');
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.');
    } 

    // En caso de tener los permisos, retornamos la ubicacion
    return await Geolocator.getCurrentPosition();
  }


  // Agregando marcador al mapa
  @override
  Future<BitmapDescriptor> createMarkerFromAsset(String path) async {
    ImageConfiguration configuration = const ImageConfiguration();
    BitmapDescriptor descriptor = await BitmapDescriptor.fromAssetImage(configuration, path);
    return descriptor;
  }

  @override
  Marker getMarker(String markerId, double lat, double lng, String title, String content, BitmapDescriptor imageMarker) {
    MarkerId id = MarkerId(markerId);

    Marker marker = Marker(
      markerId: id,
      icon: imageMarker,
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(title: title, snippet: content)
    );
    return marker;
  }

  // Tomando ubicacion del marker al mover la camara en el mapa
  @override
  Future<PlacemarkData?> getPlacemarkData(CameraPosition cameraPosition) async {
    try {
      double lat = cameraPosition.target.latitude;
      double lng = cameraPosition.target.longitude;

      List<Placemark> placemarkList = await placemarkFromCoordinates(lat, lng);
      
      if (placemarkList != null) {
        if (placemarkList.length > 0) {
          // Obtenemos los datos
          String direction = placemarkList[0].thoroughfare!; 
          String street = placemarkList[0].subThoroughfare!;
          String city = placemarkList[0].locality!;
          String department = placemarkList[0].administrativeArea!;
          
          // Armado de la ubicación
          PlacemarkData placemarkData = PlacemarkData(
            address: '$direction, $street, $city, $department', 
            lat: lat, 
            lng: lng
          );
          return placemarkData;
        }
      }
    } catch (e) {
      print('Error Geolocation Repository Impl: $e');
      return null;
    }
  }
  
  // Trazando la ruta desde el punto de origen al punto destino
  @override
  Future<List<LatLng>> getPolyline(LatLng pickUpLatLng, LatLng destinationLatLng) async {
    PolylineResult result = await PolylinePoints().getRouteBetweenCoordinates(
      API_KEY_GOOGLE,
      PointLatLng(pickUpLatLng.latitude, pickUpLatLng.longitude),
      PointLatLng(destinationLatLng.latitude, destinationLatLng.longitude),
      travelMode: TravelMode.driving,
      wayPoints: [PolylineWayPoint(location: "Córdoba, Argentina")]
    );

    List<LatLng> polylineCoordinates = [];
    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
    }
    return polylineCoordinates;
  }
  
  // @override
  // Stream<Position> getPositionStream() {
  //   LocationSettings locationSettings = LocationSettings(
  //     accuracy: LocationAccuracy.best,
  //     distanceFilter: 1
  //   );
  //   return Geolocator.getPositionStream(locationSettings: locationSettings);
  // }

}