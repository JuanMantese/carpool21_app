
import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableState.dart';
import 'package:flutter/material.dart';

class TripsAvailableItem extends StatelessWidget {
  
  TripsAvailableState state;
  PassengerRequest? passengerRequest;

  TripsAvailableItem(this.state, this.passengerRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
            title: Text('Nombre del Barrio o Sede'),
            subtitle: Text(
              state.testingArrayTrips?[0].pickupText ?? ''
            ),
          ),
          ListTile(
            title: Text('Nombre del Barrio o Sede'),
            subtitle: Text(
              state.testingArrayTrips?[0].destinationText ?? ''
            ),
          )
        ],
      ),
    );
  }

  Widget _startTripHour() {
    return  Container(
      height: 20,
      width: 60,
      margin: const EdgeInsets.only(top: 30, bottom: 15),
      child: Text('Hora') 
    );
  }
}