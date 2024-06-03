import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoState.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomButton.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomIconBack.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTextField.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// PANTALLA DONDE EL PASAJERO VA A VER EL RECORRIDO QUE HACE EL VIAJE QUE ESTA CONSULTANDO
class PassengerMapBookingInfoContent extends StatelessWidget {
  
  PassengerMapBookingInfoState state;
  
  PassengerMapBookingInfoContent(this.state ,{super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMaps(context),
        Align(
          alignment: Alignment.bottomCenter,
          child: _cardBookingInfo(context),
        ),
        Container(
          margin: EdgeInsets.only(top: 50, left: 20),
          child: CustomIconBack()
        )
      ],
    );
  }

  // Mostrando la ruta dell viaje
  Widget _googleMaps(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.5,
      child: GoogleMap(  // Mapa de Google
        mapType: MapType.normal,
        initialCameraPosition: state.cameraPosition, // Posicion inicial del mapa
        markers: Set<Marker>.of(state.markers.values), // Marcadores
        polylines: Set<Polyline>.of(state.polylines.values), // Ruta de origen a destino
        onMapCreated: (GoogleMapController controller) {
          // controller.setMapStyle('JSON');
          if (state.controller != null) {
            if (!state.controller!.isCompleted) {
              state.controller?.complete(controller);
            }
          }
        },
      ),
    );
  }

  Widget _cardBookingInfo(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.49,
      padding: EdgeInsets.only(
        left: 20, 
        right: 20,
        bottom: MediaQuery.of(context).padding.bottom
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(255, 255, 255, 255),
            Color.fromARGB(255, 186, 186, 186),
          ]
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        )
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              'Recoger en',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Text(
              state.pickUpText,
              style: TextStyle(
                fontSize: 13
              ),
            ),
            leading: Icon(Icons.location_on),
          ),

          ListTile(
            title: Text(
              'Dejar en',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            subtitle: Text(
              state.destinationText,
              style: TextStyle(
                fontSize: 13
              ),
            ),
            leading: Icon(Icons.my_location),
          ),

          ListTile(
            title: Text(
              'Tiempo y distancia aproximados',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            // subtitle: Text(
            //   '${timeAndDistanceValues.distance.text} y ${timeAndDistanceValues.duration.text}',
            //   style: TextStyle(
            //     fontSize: 13
            //   ),
            // ),
            leading: Icon(Icons.timer),
          ),

          ListTile(
            title: Text(
              'Precio',
              style: TextStyle(
                fontSize: 15
              ),
            ),
            // subtitle: Text(
            //   '\$${timeAndDistanceValues.recommendedValue}',
            //   style: TextStyle(
            //     fontSize: 13
            //   ),
            // ),
            leading: Icon(Icons.money),
          ),

          // Botón para confirmar los datos del viaje y crear el viaje.
          Spacer(),
          CustomButton(
            text: 'Confirmar viaje',
            onPressed: () {
              // Cambio de pantalla y creación del Viaje
            },
            margin: const EdgeInsets.only(
              right: 40,
              left: 40,
              bottom: 20
            ),
          ),
        ],
      )
    );
  }


}