import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeState.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/profileInfo.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/Navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

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
  void initState() {
    super.initState();
    // Obtén la instancia de UsersService
    UsersService userService = GetIt.instance<UsersService>();

    // Dispara el evento para obtener la información del pasajero
    context.read<PassengerHomeBloc>().add(GetUserInfo(userService));

    // Dispara el evento para obtener la reserva del pasajero
    context.read<PassengerHomeBloc>().add(GetCurrentReserve());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PassengerHomeBloc, PassengerHomeState>(
        builder: (context, state) {
          if (state.currentUser == null) {
            // Mostrar un indicador de carga mientras se obtiene la información del usuario
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return 
            // PassengerHomeContent(state);
            CustomNavigation(
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
