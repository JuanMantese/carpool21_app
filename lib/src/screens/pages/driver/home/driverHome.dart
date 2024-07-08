import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeState.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:carpool_21_app/src/screens/utils/globals.dart' as globals;

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

    globals.currentRole = 'driver';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DriverHomeBloc, DriverHomeState>(
        builder: (context, state) {
          if (state.currentUser == null) {
            // Mostrar un indicador de carga mientras se obtiene la información del usuario
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return CustomNavigation(
              roles: state.roles ?? [], 
              currentUser: state.currentUser!, 
            );
          }
          // return pageList[state.pageIndex];
        },
      ),
    );
  }
}