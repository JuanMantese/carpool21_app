// profile_drawer.dart
import 'package:carpool_21_app/main.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationBloc.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  // List<Widget> pageList = <Widget>[
  //   ProfileInfoPage(),
  // ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationBloc, NavigationState>(
      builder: (context, state) {
        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              const DrawerHeader(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromARGB(255, 12, 38, 145),
                      Color.fromARGB(255, 34, 156, 249),
                    ]),
                ),
                child: Text(
                  'Menu del cliente',
                  style: TextStyle(color: Colors.white),
                )),
              ListTile(
                title: const Text('Perfil'),
                // selected: state.pageIndex == 0,
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/profile');
                },
              ),
              ListTile(
                title: const Text('Cerrar Sesion'),
                onTap: () {
                  context.read<NavigationBloc>().add(Logout());
                  Navigator.pushAndRemoveUntil(
                    context, 
                    MaterialPageRoute(builder: ((context) => const MyApp())), 
                    (route) => false
                  );
                },
              )
            ],
          ),
        );
      },
    );
  }
}
