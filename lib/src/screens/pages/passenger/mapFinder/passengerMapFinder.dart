import 'dart:async';

import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderState.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomButton.dart';
import 'package:carpool_21_app/src/screens/widgets/googlePlacesAutoComplete.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';

// PANTALLA DONDE EL CONDUCTOR VA A BUSCAR LA UBICACION PARA REALIZAR SU VIAJE
class PassengerMapFinder extends StatefulWidget {
  const PassengerMapFinder({super.key});

  @override
  State<PassengerMapFinder> createState() => _PassengerMapFinderState();
}

class _PassengerMapFinderState extends State<PassengerMapFinder> {

  TextEditingController pickUpController = TextEditingController(); // Lugar origen
  TextEditingController destinationController = TextEditingController(); // Lugar destino

  @override
  void initState() {
    super.initState();

    // Espera que todos los elementos del build sean construidos antes de ejecutarse
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      // Ejecuta el Init Event cada vez que entro a la pantalla - Esto reinicia el controllador
      context.read<PassengerMapFinderBloc>().add(PassengerMapFinderInitEvent()); 
      context.read<PassengerMapFinderBloc>().add(FindPosition());
      // context.read<ClientMapSeekerBloc>().add(ListenDriversPositionSocketIO());
      // context.read<ClientMapSeekerBloc>().add(ListenDriversDisconnectedSocketIO());
    });
  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: BlocBuilder<PassengerMapFinderBloc, PassengerMapFinderState>(
        builder: (context, state) {
          return Stack(
            children: [
              GoogleMap(  // Mapa de Google
                mapType: MapType.normal,
                initialCameraPosition: state.cameraPosition, // Posicion inicial del mapa
                markers: Set<Marker>.of(state.markers.values), // Marcadores
                onCameraMove: (CameraPosition cameraPosition) {
                  // Ejecutamos el evento de onCameraMove para obtener la ubicacion en el mapa
                  context.read<PassengerMapFinderBloc>().add(OnCameraMove(cameraPosition: cameraPosition)); 
                },
                onCameraIdle: () async {
                  // Estableciendo direccion en el input referenciado al lugar que apunta el marker
                  context.read<PassengerMapFinderBloc>().add(OnCameraIdle()); 
                  pickUpController.text = state.placemarkData?.address ?? '' ;

                  // Seteando valores para enviar la informacion del Origen a otra pantalla
                  if (state.placemarkData != null) {
                    context.read<PassengerMapFinderBloc>().add(
                      OnAutoCompletedPickUpSelected(
                        lat:  state.placemarkData!.lat, 
                        lng:  state.placemarkData!.lng,
                        pickUpText:  state.placemarkData!.address,
                      )
                    ); 
                  }
                },
                onMapCreated: (GoogleMapController controller) {
                  controller.setMapStyle('JSON');

                  if (!state.controller!.isCompleted) {
                    state.controller?.complete(controller);
                  }
                },
              ),
              Container(
                height: 180,
                margin: EdgeInsets.only(top: 80),
                child: _googlePlacesAutocomplete()
              ),
              _iconMyLocation(),
              Container(
                alignment: Alignment.bottomCenter,
                child: CustomButton(
                  text: 'Continuar',
                  margin: EdgeInsets.only(left: 40, right: 40, bottom: 50), 
                  onPressed: () {
                    // Cambio de pantalla y envio de los datos a otra pantalla
                    Navigator.pushNamed(
                      context, 
                      '/passenger/map/booking',
                      arguments: {
                        'pickUpLatLng': state.pickUpLatLng,
                        'pickUpText': state.pickUpText,
                        'destinationLatLng': state.destinationLatLng,
                        'destinationText': state.destinationText,
                      }
                    );
                  }
                ),
              )
            ],
          );
        },
      ),
    );
  }

  // Seccion de inputs para definir Origen y Destino
  Widget _googlePlacesAutocomplete() {
    return Card(
      surfaceTintColor: Colors.white,
      child: Column(
        children: [
          GooglePlacesAutoComplete(
            pickUpController, 
            'Luagar de origen', 
            (Prediction prediction) {
              // Moviendo el marker (y la camara) a la posicion que ingreso el usuario en el input
              context.read<PassengerMapFinderBloc>().add(
                ChangeMapCameraPosition(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!)
                )
              ); 

              // Seteando valores para enviar la informacion del Origen a otra pantalla
              context.read<PassengerMapFinderBloc>().add(
                OnAutoCompletedPickUpSelected(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                  pickUpText: prediction.description ?? '',
                )
              ); 

              print('Lugar de Origen Lat: ${prediction.lat}');
              print('Lugar de Origen Lat: ${prediction.lng}');
            }
          ),
          SizedBox(height: 15,),
          GooglePlacesAutoComplete(
            destinationController, 
            'Luagar destino', 
            (Prediction prediction) {
              // Seteando valores para enviar la informacion del Destino a otra pantalla
              context.read<PassengerMapFinderBloc>().add(
                OnAutoCompletedDestinationSelected(
                  lat: double.parse(prediction.lat!), 
                  lng: double.parse(prediction.lng!),
                  destinationText: prediction.description ?? '',
                )
              ); 

              print('Lugar de Destino Lat: ${prediction.lat}');
              print('Lugar de Destino Lat: ${prediction.lng}');
            }
          )
        ],
      ),
    );
  }

  Widget _iconMyLocation() {
    return Container(
      margin: EdgeInsets.only(bottom: 25),
      alignment: Alignment.center,
      child: Image.asset(
        'lib/assets/img/map-maker-green.png',
        width: 50,
        height: 50,
      ),
    );
  }
}
