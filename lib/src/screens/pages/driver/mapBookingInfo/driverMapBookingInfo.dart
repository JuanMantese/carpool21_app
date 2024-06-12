import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/DriverMapBookingInfoContent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverMapBookingInfo extends StatefulWidget {
  const DriverMapBookingInfo({super.key});

  @override
  State<DriverMapBookingInfo> createState() =>
    _DriverMapBookingInfoState();
}

class _DriverMapBookingInfoState extends State<DriverMapBookingInfo> {
  // Inicializando variables
  LatLng? pickUpLatLng;
  String? pickUpText;
  LatLng? destinationLatLng;
  String? destinationText;

  @override
  void initState() {
    super.initState();

    // Espera que todos los elementos del build sean construidos antes de ejecutarse
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context
        .read<DriverMapBookingInfoBloc>()
        .add(DriverMapBookingInfoInitEvent(
          pickUpLatLng: pickUpLatLng!,
          destinationLatLng: destinationLatLng!,
          pickUpText: pickUpText!,
          destinationText: destinationText!,
        ));
      
      // Aca se ejecuta la funcion para agregar la ruta en el mapa origen/destino
      context.read<DriverMapBookingInfoBloc>().add(AddPolyline());
 
      // Ubicamos la camara sobre la ruta marcada
      context.read<DriverMapBookingInfoBloc>().add(ChangeMapCameraPosition(
        pickUpLatLng: pickUpLatLng!,
        destinationLatLng: destinationLatLng!
      ));

      // Trayendo los datos: Tiempo estimado del trayecto y Distancia del punto de origen al punto de destino
      context.read<DriverMapBookingInfoBloc>().add(GetTimeAndDistanceValues());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibiendo los datos de Origen y Destino desde DriverMapFinder
    Map<String, dynamic> arguments =
      ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Seteando valores
    pickUpLatLng = arguments['pickUpLatLng'];
    pickUpText = arguments['pickUpText'];
    destinationLatLng = arguments['destinationLatLng'];
    destinationText = arguments['destinationText'];
    print('pickUpLatLng ${pickUpLatLng}');
    print('pickUpText ${pickUpText}');
    print('destinationLatLng ${destinationLatLng}');
    print('destinationText ${destinationText}');

    return Scaffold(
      body: BlocBuilder<DriverMapBookingInfoBloc, DriverMapBookingInfoState>(
        builder: (context, state) {
          final responseTimeAndDistance = state.responseTimeAndDistance;

          if (responseTimeAndDistance is Loading) {
            return const Center(child: CircularProgressIndicator());
          }
          else if (responseTimeAndDistance is Success) {
            TimeAndDistanceValues timeAndDistanceValues = responseTimeAndDistance.data as TimeAndDistanceValues;
            return Scaffold(
              body: DriverMapBookingInfoContent(state, timeAndDistanceValues)
            );
          }

          // DELETE - Eliminar: Esta puesto para probar sin el back
          TimeAndDistanceValues mockTimeAndDistanceValues = TimeAndDistanceValues(
            tripPrice: 10.0,
            destinationAddresses: "Destino ficticio",
            originAddresses: "Origen ficticio",
            distance: Distance(text: "10 km", value: 10.0),
            duration: Duration(text: "15 minutos", value: 15.0),
          );
          return Scaffold(
              body: DriverMapBookingInfoContent(
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
