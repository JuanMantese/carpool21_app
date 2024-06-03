import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeState.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomeState();
}

class _DriverHomeState extends State<DriverHomePage> {
  
  @override
  void initState() {
    super.initState();
    // Obtén la instancia de UsersService
    UsersService userService = GetIt.instance<UsersService>();

    // Dispara el evento para obtener la información del usuario
    context.read<DriverHomeBloc>().add(GetUserInfo(userService));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Menu de Opciones'),
      // ),
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          if (state.currentUser == null) {
            // Mostrar un indicador de carga mientras se obtiene la información del usuario
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CustomNavigation(
              roles: state.roles ?? [], 
              currentUser: state.currentUser!, 
              userService: state.userService!,
            );
          }
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