import 'package:carpool_21_app/src/screens/widgets/drawer/Drawer.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationBloc.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CustomNavigation extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for Scaffold

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            endDrawer: const CustomDrawer(), // Add Drawer to the Scaffold
            body: Center(
              child: _buildPage(state),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              selectedItemColor: Colors.green,
              unselectedItemColor: Colors.grey,
              onTap: (index) {
                if (NavigationState.values[index] == NavigationState.perfil) {
                  _scaffoldKey.currentState?.openEndDrawer(); // Open Drawer to Profile option
                } else {
                  context.read<NavigationBloc>().add(NavigationEvent.values[index]);
                }
              },
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Inicio',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.book),
                  label: 'Reservas',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.directions_car),
                  label: 'Viaje',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Perfil',
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildPage(NavigationState state) {
    switch (state) {
      case NavigationState.inicio:
        return Text('Inicio Page');
      case NavigationState.reservas:
        return Text('Reservas Page');
      case NavigationState.viaje:
        return Text('Viaje Page');
      case NavigationState.perfil:
        return Text('Perfil Page');
      default:
        return Text('Page not found');
    }
  }
}

// void main() => runApp(MaterialApp(home: CustomNavigation()));
