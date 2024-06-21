import 'package:carpool_21_app/src/screens/widgets/CustomDialog.dart';
import 'package:carpool_21_app/src/screens/widgets/CustomDialogTrip.dart';
import 'package:flutter/material.dart';

class DriverHomeContent extends StatelessWidget {
  const DriverHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            _headerHome(context),

            Padding(
              padding: const EdgeInsets.only(
                top: 16, 
                bottom: 16, 
                left: 26, 
                right: 26
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      'Bienvenido nuevamente Juan!',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                        color: Color(0xFF00A48B),
                      ),
                    ),
                  ),

                  const SizedBox(height: 22),
                  const Text(
                    'Mis Vehiculos',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A48B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _vehicleCard(context),

                  const SizedBox(height: 22),
                  const Text(
                    'Viajes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF00A48B),
                    ),
                  ),
                  const SizedBox(height: 8),
                  _tripsCard(context),
                ],
              ),
            ),
          ],
        ),
      ]
    );
  }

  Widget _headerHome(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            // Color.fromARGB(255, 109, 11, 0), // Top color
            Color.fromARGB(255, 0, 73, 60), // Top color
            Color(0xFF00A48B), // Bottom color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(30), 
          bottomRight: Radius.circular(30), 
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00A48B).withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 10), // Shadow offset distance in x,y
          )
        ],
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top + 30,
          bottom: 30, 
          right: 15, 
          left: 15, 
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'lib/assets/img/Header-Logo-Mini.png',
              height: 85,
              width: 300,
            ),
            const SizedBox(width: 16),
            IconButton(
              icon: const Icon(
                Icons.notifications,
                size: 36,
                color: Colors.white,
              ),
              onPressed: () {
                print("Notificaciones");
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _vehicleCard(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: const Color(0xFFF9F9F9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.drive_eta_rounded, 
                    size: 50, 
                    color: Color(0xFF00A48B)
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 150,
                    child: Text(
                      'Sin vehículos registrados',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, '/car/register');
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F9F9),
                  side: const BorderSide(
                    color: Color(0xFF00A98F),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  '+  Nuevo',
                  style: TextStyle(
                    color: Color(0xFF00A98F),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tripsCard(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        color: const Color(0xFFF9F9F9),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.calendar_month_rounded, 
                    size: 50, 
                    color: Color(0xFF00A48B)
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 150,
                    child: Text(
                      'Sin viajes programados',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[600],
                      ),
                      overflow: TextOverflow.clip,
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  print("Nuevo viaje");

                  // Verificamos que el usuario tenga al menos 1 vehiculo registrado
                  { 1 > 0 ? 
                    CustomDialog(
                      context: context,
                      title: '¡No puedes crear un viaje!',
                      content: 'Debes tener al menos 1 vehículo registrado para poder ofrecer viajes.\n¿Deseas registrar tu vehículo?',
                      icon: Icons.warning_rounded,
                      onPressedSend: () {
                        Navigator.of(context).pop();
                        Navigator.pushNamed(context, '/car/register');
                      },
                      textSendBtn: 'Registrar',
                      textCancelBtn: 'Cancelar',
                    )
                  :
                    CustomDialogTrip(
                      context: context,
                    );
                  }
                },
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xFFF9F9F9),
                  side: const BorderSide(
                    color: Color(0xFF00A98F),
                  ),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  '+  Nuevo',
                  style: TextStyle(
                    color: Color(0xFF00A98F),
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

