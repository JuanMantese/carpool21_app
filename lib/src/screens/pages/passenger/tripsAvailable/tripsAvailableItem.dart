
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableState.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TripsAvailableItem extends StatelessWidget {
  
  TripsAvailableState state;
  TripDetail? passengerRequest;

  TripsAvailableItem(this.state, this.passengerRequest, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          ListTile(
              leading: const Icon(Icons.location_on, color: Colors.teal),
              title: Text(
                passengerRequest!.pickupNeighborhood ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(passengerRequest!.pickupText ?? ''),
            ),
            ListTile(
              leading: const Icon(Icons.location_on, color: Colors.teal),
              title: Text(
                passengerRequest!.destinationNeighborhood ?? '',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text(passengerRequest!.destinationText ?? ''),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _startTripHour(passengerRequest!.departureTime),
                _availableSeats(passengerRequest!.availableSeats),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
              child: Text(
                // 'con ${passengerRequest.car.brand} ${passengerRequest.car.model}',
                'Juan',
                style: TextStyle(color: Colors.grey),
              ),
            ),
        ],
      ),
    );
  }

  Widget _startTripHour(String departureTime) {
    final formattedTime = DateFormat.Hm().format(DateTime.parse(departureTime));
    return Container(
      height: 40,
      width: 80,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          formattedTime,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _availableSeats(int availableSeats) {
    return Container(
      height: 40,
      width: 60,
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Center(
        child: Text(
          '$availableSeats Lugares',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}