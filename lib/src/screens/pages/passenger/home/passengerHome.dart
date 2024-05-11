import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeState.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/profileInfo.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerHomePage extends StatefulWidget {
  const PassengerHomePage({super.key});

  @override
  State<PassengerHomePage> createState() => _PassengerHomeState();
}

class _PassengerHomeState extends State<PassengerHomePage> {
  // Defining the screens that I will be able to access
  List<Widget> pageList = <Widget>[
    ProfileInfoPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Menu de Opciones'),
      // ),
      body: BlocBuilder<PassengerHomeBloc, PassengerHomeState>(
        builder: (context, state) {
          return CustomNavigation();
          // return pageList[state.pageIndex];
        },
      ),

      // drawer: BlocBuilder<PassengerHomeBloc, PassengerHomeState>(
      //   builder: (context, state) {
      //     return Drawer(
      //       child: ListView(
      //         padding: EdgeInsets.zero,
      //         children: [
      //           const DrawerHeader(
      //               decoration: BoxDecoration(
      //                 gradient: LinearGradient(
      //                   begin: Alignment.topRight,
      //                   end: Alignment.bottomLeft,
      //                   colors: [
      //                     Color.fromARGB(255, 12, 38, 145),
      //                     Color.fromARGB(255, 34, 156, 249),
      //                   ]),
      //               ),
      //               child: Text(
      //                 'Menu del cliente',
      //                 style: TextStyle(color: Colors.white),
      //               )),
      //           ListTile(
      //             title: const Text('Perfil'),
      //             selected: state.pageIndex == 0,
      //             onTap: () {
      //               context
      //                 .read<PassengerHomeBloc>()
      //                 .add(ChangeDrawerPage(pageIndex: 0));
      //               Navigator.pop(context);
      //             },
      //           )
      //         ],
      //       ),
      //     );
      //   },
      // ),
    );
  }
}
