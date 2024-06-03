import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoState.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/passengerMapBookingInfoContent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PassengerMapBookingInfo extends StatefulWidget {
  const PassengerMapBookingInfo({super.key});

  @override
  State<PassengerMapBookingInfo> createState() =>
    _PassengerMapBookingInfoState();
}

class _PassengerMapBookingInfoState extends State<PassengerMapBookingInfo> {
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
        .read<PassengerMapBookingInfoBloc>()
        .add(PassengerMapBookingInfoInitEvent(
          pickUpLatLng: pickUpLatLng!,
          destinationLatLng: destinationLatLng!,
          pickUpText: pickUpText!,
          destinationText: destinationText!,
        ));
      
      // Aca se ejecuta la funcion para agregar la ruta en el mapa origen/destino
      context.read<PassengerMapBookingInfoBloc>().add(AddPolyline());

      // Ubicamos la camara sobre la ruta marcada
      context.read<PassengerMapBookingInfoBloc>().add(ChangeMapCameraPosition(
        lat: pickUpLatLng!.latitude, lng: pickUpLatLng!.longitude));
 
      // context.read<PassengerMapBookingInfoBloc>().add(GetTimeAndDistanceValues());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibiendo los datos de Origen y Destino desde passengerMapFinder
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
      body: BlocBuilder<PassengerMapBookingInfoBloc, PassengerMapBookingInfoState>(
        builder: (context, state) {
          return Scaffold(
            body: PassengerMapBookingInfoContent(state)
          );
        },
      ),
    );
  }
}
