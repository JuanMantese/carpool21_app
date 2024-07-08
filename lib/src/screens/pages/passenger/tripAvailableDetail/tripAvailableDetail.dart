import 'package:carpool_21_app/src/domain/models/reserveDetail.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailState.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/tripAvailableDetailContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class TripAvailableDetailPage extends StatefulWidget {
  const TripAvailableDetailPage({super.key});

  @override
  State<TripAvailableDetailPage> createState() => _TripAvailableDetailPageState();
}

class _TripAvailableDetailPageState extends State<TripAvailableDetailPage> {
  // Inicializando variables
  int? idTrip;
  LatLng? pickUpLatLng;
  String? pickUpText;
  LatLng? destinationLatLng;
  String? destinationText;
  String? departureTime;
  double? compensation;
  Driver? driver;

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
          departureTime: departureTime!,
          compensation: compensation!,
          driver: driver!,
        ));
      
      // Aca se ejecuta la funcion para agregar la ruta en el mapa origen/destino
      context.read<TripAvailableDetailBloc>().add(AddPolyline());
 
      // Ubicamos la camara sobre la ruta marcada
      context.read<TripAvailableDetailBloc>().add(ChangeMapCameraPosition(
        pickUpLatLng: pickUpLatLng!,
        destinationLatLng: destinationLatLng!
      ));

      // Trayendo los datos: Tiempo estimado del trayecto y Distancia del punto de origen al punto de destino
      // context.read<TripAvailableDetailBloc>().add(GetTimeAndDistanceValues());
    });
  }

  @override
  Widget build(BuildContext context) {
    // Recibiendo los datos de Origen y Destino desde AvailableTrips
    Map<String, dynamic> arguments = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;

    // Seteando valores
    idTrip = arguments['idTrip'];
    pickUpLatLng = arguments['pickUpLatLng'];
    pickUpText = arguments['pickUpText'];
    destinationLatLng = arguments['destinationLatLng'];
    destinationText = arguments['destinationText'];
    departureTime = arguments['departureTime'];
    driver = arguments['driver'];
    compensation = arguments['compensation'];
    print('idTrip ${idTrip}');
    print('pickUpLatLng ${pickUpLatLng}');
    print('pickUpText ${pickUpText}');
    print('destinationLatLng ${destinationLatLng}');
    print('destinationText ${destinationText}');
    print('departureTime ${departureTime}');

    return Scaffold(
      body: BlocListener<TripAvailableDetailBloc, TripAvailableDetailState>(
        listener: (context, state) {
          final responseReserveRes = state.responseReserve;
          print('Click');
          print(responseReserveRes);

          if (responseReserveRes is Loading) {
            print('Cargando...');
          }
          else if (responseReserveRes is Success) { 
            print('Entro en responseReserveRes');
            ReserveDetail responseReserve = responseReserveRes.data; 
            print(responseReserve.toJson());
            int? idReserve = responseReserve.idReservation;
            print(idReserve);
            Navigator.pushNamed(context, '/passenger/reserve/detail',
              arguments: {
                'idReserve': idReserve,
              }
            );
            Fluttertoast.showToast(msg: 'Reserva realizada', toastLength: Toast.LENGTH_LONG);
          }
        },
        child: BlocBuilder<TripAvailableDetailBloc, TripAvailableDetailState>(
          builder: (context, state) {          

          return Scaffold(
            body: TripAvailableDetailContent(
              state, 
              onReserve: () {
                context.read<TripAvailableDetailBloc>().add(CreateReserve(tripRequestId: idTrip!));
              }
            )
          );
           
          // DESCOMENTAR
          // return Container(); 
          })  
        ,
      ),
    );
  }
}