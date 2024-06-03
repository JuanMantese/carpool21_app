import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderEvent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomDialogTrip extends StatelessWidget {
  
  final BuildContext context;

  CustomDialogTrip({
    super.key,
    required this.context, 
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return this;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      title: const Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.directions_car_rounded,
            size: 40,
            color: Color(0xFF006D59),
          ),
          SizedBox(height: 10),
          Text(
            'Elegí tu ruta!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      
      content: Text(
        'Elegí el lugar de Origen/Destino de tu viaje.'
      ),
      
      actions: <Widget>[
        ButtonBar(
          mainAxisSize: MainAxisSize.max,
          alignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              // onPressed: () {
              //   Navigator.pop(context);
              // },
              onPressed: () {
                _setPredefinedLocation(
                  context,
                  LatLng(-31.441722, -64.195714), // Coordenadas del Campus Universitario
                  'destination',
                );
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00A98F)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Hacia Campus Universitaro',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00A98F)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Hacia Sede Nueva Córdoba',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00A98F)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Desde Campus Universitaro',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00A98F)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Desde Sede Nueva Córdoba',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF00A98F)),
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
              ),
              child: const Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.black87,
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        )
      ],
    );
  }

  void _setPredefinedLocation(BuildContext context, LatLng location, String locationType) {
    Navigator.pop(context); // Cerrar el diálogo
    Navigator.pushNamed(context, '/passenger/finder'); // Navegar al mapa
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PassengerMapFinderBloc>().add(SelectPredefinedLocation(location: location, locationType: locationType));
    });
  }
}