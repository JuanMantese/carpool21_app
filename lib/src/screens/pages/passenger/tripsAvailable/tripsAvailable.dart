import 'package:carpool_21_app/src/domain/models/passengerRequest.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableState.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/tripsAvailableItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TripsAvailablePage extends StatefulWidget {
  const TripsAvailablePage({super.key});

  @override
  State<TripsAvailablePage> createState() => _TripsAvailablePageState();
}

class _TripsAvailablePageState extends State<TripsAvailablePage> {

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<TripsAvailableBloc>().add(GetNearbyTripRequest(driverLat: -31.322187, driverLng: -64.2219203));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<TripsAvailableBloc, TripsAvailableState>(
        builder: (context, state) {
          final response = state.response;

          if (response is Loading) {
            return const Center(child: CircularProgressIndicator());
          } else if (response is Success) {
            List<PassengerRequest> passengerRequests = response.data as List<PassengerRequest>;
            
            // Permite listar la informacion que viene dentro de una Lista
            return ListView.builder(
              itemCount: passengerRequests.length,
              itemBuilder: (context, index) {
                return TripsAvailableItem(state, passengerRequests[index]);
              },
            );
          }

          // DELETE - Utilizamos un Array de prueba
          if (state.testingArrayTrips != null) {           
            return Container(
              child: ListView.builder(
                itemCount: state.testingArrayTrips?.length,
                itemBuilder: (context, index) {
                  return TripsAvailableItem(state, state.testingArrayTrips?[index]);
                },
              )
            );
          } else {
            return Container(
              child: Text('No logramos entrar')
            );
          }
        },
      ),
    );
  }
}