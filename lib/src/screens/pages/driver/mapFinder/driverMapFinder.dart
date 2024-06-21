
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderState.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomButton.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomIconBack.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTimePicker.dart';
import 'package:carpool_21_app/src/screens/widgets/googlePlacesAutoComplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

// PANTALLA DONDE EL CONDUCTOR VA A BUSCAR LA UBICACION PARA REALIZAR SU VIAJE
class DriverMapFinder extends StatefulWidget {
  const DriverMapFinder({super.key});

  @override
  State<DriverMapFinder> createState() => _DriverMapFinderState();
}

class _DriverMapFinderState extends State<DriverMapFinder> with WidgetsBindingObserver {

  TextEditingController pickUpController = TextEditingController(); // Lugar origen
  TextEditingController destinationController = TextEditingController(); // Lugar destino

  @override
  void initState() {
    super.initState();

    // Añadir listeners a los TextEditingControllers - Escuchamos los cambios
    pickUpController.addListener(_onPickUpChanged);
    destinationController.addListener(_onDestinationChanged);

    // Añadir observer para detectar cuando la aplicación cambia de estado
    WidgetsBinding.instance.addObserver(this);

    // Espera que todos los elementos del build sean construidos antes de ejecutarse
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Ejecuta el Init Event cada vez que entro a la pantalla - Esto reinicia el controllador
      context.read<DriverMapFinderBloc>().add(DriverMapFinderInitEvent());
      context.read<DriverMapFinderBloc>().add(ConnectSocketIO());
      context.read<DriverMapFinderBloc>().add(FindPosition());

      // context.read<ClientMapSeekerBloc>().add(ListenDriversPositionSocketIO());
      // context.read<ClientMapSeekerBloc>().add(ListenDriversDisconnectedSocketIO());
    });
  }

  // Remover listeners y observer cuando el widget se elimine (El evento se dispara cuando pasamos a otra pantalla)
  @override
  void dispose() {
    pickUpController.removeListener(_onPickUpChanged);
    destinationController.removeListener(_onDestinationChanged);
    pickUpController.dispose();
    destinationController.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  // Resetea el estado del input de origen
  void _onPickUpChanged() {
    if (pickUpController.text.isEmpty) {
      context.read<DriverMapFinderBloc>().add(ClearPickUpLocation());
    }
  }

  // Resetea el estado del input de destino
  void _onDestinationChanged() {
    if (destinationController.text.isEmpty) {
      context.read<DriverMapFinderBloc>().add(ClearDestinationLocation());
    }
  }

  // Validamos si los campos estan completados para que el boton funcione
  bool _isButtonEnabled(DriverMapFinderState state) {
    return state.pickUpLatLng != null &&
           state.pickUpText.isNotEmpty &&
           state.destinationLatLng != null &&
           state.destinationText.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      // Resetea el estado del mapa cuando el usuario sale de la pantalla
      onPopInvoked: (popDisposition) async {
        context.read<DriverMapFinderBloc>().add(DriverMapFinderResetEvent());
        return;
      },
      child: Scaffold(
      body: BlocBuilder<DriverMapFinderBloc, DriverMapFinderState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(
                // Mapa de Google
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition, // Posicion inicial del mapa
                markers: Set<Marker>.of(state.markers.values), // Marcadores
                polylines: Set<Polyline>.of(state.polylines.values), // Ruta en el mapa

                // DELETE - ELIMINAR Funcion que no se va a utilizar
                // onCameraMove: (CameraPosition cameraPosition) {
                //   // Ejecutamos el evento de onCameraMove para obtener la ubicacion que el usuario esta elijiendo en el mapa
                //   context.read<DriverMapFinderBloc>().add(OnCameraMove(cameraPosition: cameraPosition));
                // },
                // onCameraIdle: () async {
                //   // Estableciendo direccion en el input referenciado al lugar que apunta el marker
                //   context.read<DriverMapFinderBloc>().add(OnCameraIdle());
                //   pickUpController.text = state.placemarkData?.address ?? '' ;

                //   // Seteando valores para enviar la informacion del Origen a otra pantalla
                //   if (state.placemarkData != null) {
                //     context.read<DriverMapFinderBloc>().add(
                //       OnAutoCompletedPickUpSelected(
                //         lat: state.placemarkData!.lat,
                //         lng: state.placemarkData!.lng,
                //         pickUpText: state.placemarkData!.address,
                //       )
                //     );
                //   }
                // },
                // DELETE - ELIMINAR Funcion que no se va a utilizar

                onMapCreated: (GoogleMapController controller) {
                  // controller.setMapStyle('JSON');
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  }
                },
              ),
              CustomIconBack(
                color: Colors.black,
                margin: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 180, left: 30),
                onPressed: () {
                  context.read<DriverMapFinderBloc>().add(DriverMapFinderResetEvent());
                  Navigator.pop(context);
                }, 
              ),
              IntrinsicHeight(
                child: Container(
                  // height: 120,
                  margin: const EdgeInsets.only(top: 80),
                  child: _googlePlacesAutocomplete()
                ),
              ),

              // DELETE - ELIMINAR puntero al medio del mapa
              // _iconMyLocation(),
              // DELETE -

              Container(
                alignment: Alignment.bottomCenter,
                margin: EdgeInsets.only(
                    right: 60,
                    left: 60,
                    bottom: MediaQuery.of(context).padding.bottom),
                child: CustomButton(
                  text: 'Continuar',
                  // onPressed: () {
                  //   // Cambio de pantalla y envio de los datos a otra pantalla
                  //   Navigator.pushNamed(context, '/driver/map/booking',
                  //     arguments: {
                  //       'pickUpLatLng': state.pickUpLatLng,
                  //       'pickUpText': state.pickUpText,
                  //       'destinationLatLng': state.destinationLatLng,
                  //       'destinationText': state.destinationText,
                  //     }
                  //   );
                  // }
                  onPressed: _isButtonEnabled(state) ? () {
                      // Cambio de pantalla y envio de los datos a otra pantalla
                      Navigator.pushNamed(context, '/driver/map/booking',
                        arguments: {
                          'pickUpLatLng': state.pickUpLatLng,
                          'pickUpText': state.pickUpText,
                          'destinationLatLng': state.destinationLatLng,
                          'destinationText': state.destinationText,
                        }
                      );
                    } : () {},
        
                ),
              )
            ],
          );
        },
      ),
    )
    );
  }

  // Seccion de inputs para definir Origen y Destino
  Widget _googlePlacesAutocomplete() {
    return Card(
      margin: const EdgeInsets.only(right: 18, left: 18),
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          BlocBuilder<DriverMapFinderBloc, DriverMapFinderState>(
            builder: (context, state) {
              return GooglePlacesAutoComplete(
                pickUpController,
                state.pickUpText.isNotEmpty ? state.pickUpText : 'Luagar de origen',
                (Prediction prediction) {
                  // Moviendo la camara a la posicion que ingreso el usuario en el input y agregando el marker a esa posicion
                  context.read<DriverMapFinderBloc>().add(
                    ChangeMapCameraPosition(
                      lat: double.parse(prediction.lat!),
                      lng: double.parse(prediction.lng!)));

                  // Seteando valores para enviar la informacion del Origen a otra pantalla
                  context
                    .read<DriverMapFinderBloc>()
                    .add(OnAutoCompletedPickUpSelected(
                      lat: double.parse(prediction.lat!),
                      lng: double.parse(prediction.lng!),
                      pickUpText: prediction.description ?? '',
                    ));

                  print('Lugar de Origen Lat: ${prediction.lat}');
                  print('Lugar de Origen Lat: ${prediction.lng}');
                },
                enabled: state.pickUpLatLng != null && state.isLocationSelected,
              );
            },
          ),
          SizedBox(
            height: 15,
          ),
          BlocBuilder<DriverMapFinderBloc, DriverMapFinderState>(
            builder: (context, state) {
              return GooglePlacesAutoComplete(
                destinationController,
                state.destinationText.isNotEmpty ? state.destinationText : 'Luagar destino',
                (Prediction prediction) {
                  // Seteando valores para enviar la informacion del Destino a otra pantalla
                  context
                    .read<DriverMapFinderBloc>()
                    .add(OnAutoCompletedDestinationSelected(
                      lat: double.parse(prediction.lat!),
                      lng: double.parse(prediction.lng!),
                      destinationText: prediction.description ?? '',
                    ));

                  print('Lugar de Destino Lat: ${prediction.lat}');
                  print('Lugar de Destino Lat: ${prediction.lng}');
                },
                enabled: state.destinationLatLng != null && state.isLocationSelected,
              );
            },
          ),
          SizedBox(
            height: 15
          ),
          CustomTimePicker(
            labelText: 'Hora de partida',
            onTimeChanged: (time) {
              print('Hora seleccionada: $time');
            },
          ),
        ],
      ),
    );
  }

  // DELETE - ELIMINAR armado del icono en medio de la pantalla
  // Widget _iconMyLocation() {
  //   return Container(
  //     margin: const EdgeInsets.only(bottom: 25),
  //     alignment: Alignment.center,
  //     child: Image.asset(
  //       'lib/assets/img/map-marker-green.png',
  //       width: 50,
  //       height: 50,
  //     ),
  //   );
  // }
}
