
import 'package:carpool_21_app/src/domain/useCases/geolocation/createMarkerUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/findPositionUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/getMarkerUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/getPlacemarkDataUseCase.dart';

class GeolocationUseCases {

  FindPositionUseCase findPosition;
  CreateMarkerUseCase createMarker;
  GetMarkerUseCase getMarker;
  GetPlacemarkDataUseCase getPlacemarkData;
  // GetPolylineUseCase getPolyline;
  // GetPositionStreamUseCase getPositionStream;

  GeolocationUseCases({
    required this.findPosition,
    required this.createMarker,
    required this.getMarker,
    required this.getPlacemarkData,
    // required this.getPolyline,
    // required this.getPositionStream,
  });

}