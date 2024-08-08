import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailState.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/tripAvailableDetailContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripAvailableDetailPage extends StatefulWidget {
  const TripAvailableDetailPage({super.key});

  @override
  State<TripAvailableDetailPage> createState() => _TripAvailableDetailPageState();
}

class _TripAvailableDetailPageState extends State<TripAvailableDetailPage> {
  // Inicializando variables
  LatLng? pickUpLatLng;
  String? pickUpText;
  LatLng? destinationLatLng;
  String? destinationText;
  String? departureTime;

  @override
  void initState() {
    super.initState();

    // Espera que todos los elementos del build sean construidos antes de ejecutarse
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
        .read<TripAvailableDetailBloc>()
        .add(TripAvailableDetailInitEvent(
          pickUpLatLng: pickUpLatLng!,
          destinationLatLng: destinationLatLng!,
          pickUpText: pickUpText!,
          destinationText: destinationText!,
          departureTime: departureTime!
        ));
      
      // Aca se ejecuta la funcion para agregar la ruta en el mapa origen/destino
      context.read<TripAvailableDetailBloc>().add(AddPolyline());
 
      // Ubicamos la camara sobre la ruta marcada
      context.read<TripAvailableDetailBloc>().add(ChangeMapCameraPosition(
        pickUpLatLng: pickUpLatLng!,
        destinationLatLng: destinationLatLng!
      ));

      // Trayendo los datos: Tiempo estimado del trayecto y Distancia del punto de origen al punto de destino
      context.read<TripAvailableDetailBloc>().add(GetTimeAndDistanceValues());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibiendo los datos de Origen y Destino desde AvailableTrips
    Map<String, dynamic> arguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Seteando valores
    pickUpLatLng = arguments['pickUpLatLng'];
    pickUpText = arguments['pickUpText'];
    destinationLatLng = arguments['destinationLatLng'];
    destinationText = arguments['destinationText'];
    departureTime = arguments['departureTime'];
    print('pickUpLatLng ${pickUpLatLng}');
    print('pickUpText ${pickUpText}');
    print('destinationLatLng ${destinationLatLng}');
    print('destinationText ${destinationText}');
    print('departureTime ${departureTime}');

    return Scaffold(
      body: BlocBuilder<TripAvailableDetailBloc, TripAvailableDetailState>(
        builder: (context, state) {
          final responseTimeAndDistance = state.responseTimeAndDistance;

          if (responseTimeAndDistance is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (responseTimeAndDistance is Success) {
            TimeAndDistanceValues timeAndDistanceValues = responseTimeAndDistance.data as TimeAndDistanceValues;
            return Scaffold(
              body: TripAvailableDetailContent(state, timeAndDistanceValues)
            );
          }

          // DELETE - Eliminar: Esta puesto para probar sin el back
          TimeAndDistanceValues mockTimeAndDistanceValues = TimeAndDistanceValues(
            tripPrice: 1000.0,
            distance: Distance(text: "10 km", value: 10.0),
            duration: Duration(text: "15 min", value: 15.0),
          );
          return Scaffold(
              body: TripAvailableDetailContent(
                state, 
                mockTimeAndDistanceValues
              )
            );
          // DELETE - Eliminar: Esta puesto para probar sin el back
           
          // DESCOMENTAR
          // return Container(); 
        },
      ),
    );
  }
}