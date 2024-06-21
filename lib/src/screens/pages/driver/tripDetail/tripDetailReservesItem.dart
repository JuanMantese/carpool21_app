// import 'package:flutter/material.dart';

// class TripDetailReservesItem extends StatelessWidget {
//   const TripDetailReservesItem({super.key});

//   // Card para mostrar la informacion de los pasajeros que reservaron un viaje
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }

//   // REVISAR ESTE CODIGO
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         FareOfferedDialog(
//           context, 
//           () {
//             if (clientRequest != null && state.idDriver != null && context.read<DriverClientRequestsBloc>().state.fareOffered.value.isNotEmpty) {
//               context.read<DriverClientRequestsBloc>().add(
//                 CreateDriverTripRequest(
//                   driverTripRequest: DriverTripRequest(
//                     idDriver: state.idDriver!, 
//                     idClientRequest: clientRequest!.id, 
//                     fareOffered: double.parse(context.read<DriverClientRequestsBloc>().state.fareOffered.value), 
//                     time: clientRequest!.googleDistanceMatrix!.duration.value.toDouble() / 60, 
//                     distance: clientRequest!.googleDistanceMatrix!.distance.value.toDouble() / 1000, 
//                   )
//                 )
//               );
//             }
//             else {
//               Fluttertoast.showToast(msg: 'No se puede enviar la oferta', toastLength: Toast.LENGTH_LONG);
//             }
//         });
//       },
//       child: Card(
//         child: Column(
//           children: [
//             ListTile(
//               trailing: _imageUser(),
//               title: Text(
//                 'Tarifa ofrecida: \$${clientRequest?.fareOffered}',
//                 style: TextStyle(
//                   color: Colors.blueAccent,
//                   fontWeight: FontWeight.bold
//                 ),
//               ),
//               subtitle: Text(
//                 '${clientRequest?.client.name} ${clientRequest?.client.lastname}',
//                 style: TextStyle(
//                   fontSize: 16,
//                   color: Colors.blue[900]
//                 ),
//               ),
//             ),
//             ListTile(
//               title: Text('Datos del viaje'),
//               subtitle: Column(
//                 children: [
//                   _textPickup(),
//                   _textDestination()
//                 ],
//               ),
//             ),
//             ListTile(
//               title: Text('Tiempo y Distancia'),
//               subtitle: Column(
//                 children: [
//                   _textMinutes(),
//                   _textDistance()
//                 ],
//               ),
//             ),
            
//           ],
//         ),
//       ),
//     );
//   }

//   // Imagen del Pasajero
//   Widget _imageUser() {
//     return Container(
//         width: 60,
//         // margin: EdgeInsets.only(top: 25, bottom: 15),
//         child: AspectRatio(
//           aspectRatio: 1,
//           child: ClipOval(
//             child: tripReserve != null 
//             ? tripReserve!.passenger.image != null 
//               ? FadeInImage.assetNetwork(
//                 placeholder: 'assets/img/user_image.png', 
//                 image: tripReserve?.passenger.image,
//                 fit: BoxFit.cover,
//                 fadeInDuration: Duration(seconds: 1),
//               )
//               : Image.asset(
//                 'assets/img/user_image.png',
//               )
//             : Container(),
//           ),
//         ),
//       );
//   }
// }