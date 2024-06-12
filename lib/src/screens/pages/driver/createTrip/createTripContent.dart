import 'package:carpool_21_app/src/domain/models/timeAndDistanceValue.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoState.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomButton.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomTimePicker.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CreateTripContent extends StatelessWidget {
  
  final String pickUpText;
  final String destinationText;
  final TimeAndDistanceValues timeAndDistanceValues;
  final DriverMapBookingInfoState state;
  final ValueChanged<String?> onVehicleChanged;
  final ValueChanged<String?> onAvailableSeatsChanged;
  final ValueChanged<String> onDepartureTimeChanged;
  final VoidCallback onConfirm;

  CreateTripContent({
    required this.pickUpText,
    required this.destinationText,
    required this.timeAndDistanceValues,
    required this.state,
    required this.onVehicleChanged,
    required this.onAvailableSeatsChanged,
    required this.onDepartureTimeChanged,
    required this.onConfirm,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTripInfoCard(context),
        SizedBox(height: 16.0),
        _buildDetailForm(context),
        SizedBox(height: 16.0),
        CustomButton(
          text: 'Confirmar Viaje',
          onPressed: onConfirm,
        ),
      ],
    );
  }

  Widget _buildTripInfoCard(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      color: Colors.white,
      surfaceTintColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              leading: const Icon(
                Icons.my_location,
                color: Color(0xFF3b82f6),
              ),
              title: Text(
                pickUpText,
              ),
              titleTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),
            ListTile(
              leading: const Icon(
                Icons.location_on,
                color: Color(0xFFdc2627),
              ),
              title: Text(destinationText),
              titleTextStyle: const TextStyle(
                fontSize: 14,
                color: Colors.black
              ),
            ),

            SizedBox(
              height: 200,
              child: GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: false,
                initialCameraPosition: state.cameraPosition,
                markers: Set<Marker>.of(state.markers.values),
                polylines: Set<Polyline>.of(state.polylines.values),
                onMapCreated: (GoogleMapController controller) {
                  if (state.controller != null) {
                    if (!state.controller!.isCompleted) {
                      state.controller?.complete(controller);
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailForm(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Vehículo',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: <String>['Vehículo 1', 'Vehículo 2', 'Vehículo 3']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onVehicleChanged,
        ),
        const SizedBox(height: 16.0),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'Plazas disponibles',
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          items: <String>['1', '2', '3', '4']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: onAvailableSeatsChanged,
        ),
        const SizedBox(height: 16.0),
        CustomTimePicker(
          labelText: 'Horario de partida',
          onTimeChanged: onDepartureTimeChanged,
        ),
      ],
    );
  }
}