import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/Drawer.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationBloc.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationState.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CustomNavigation extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); // Key for Scaffold

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigationBloc(GetIt.instance<AuthUseCases>()),
      child: BlocBuilder<NavigationBloc, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            key: _scaffoldKey,
            endDrawer: CustomDrawer(), // Add Drawer to the Scaffold
            body: Center(
              child: _buildPage(state),
            ),
            bottomNavigationBar: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              currentIndex: state.index,
              selectedItemColor: const Color(0xFF00A98F),
              unselectedItemColor: const Color.fromARGB(255, 111, 111, 111),
              onTap: (index) {
                // Emit events based on the index
                switch (index) {
                  case 0:
                    context.read<NavigationBloc>().add(ShowInicio());
                    break;
                  case 1:
                    context.read<NavigationBloc>().add(ShowReservas());
                    break;
                  case 2:
                    context.read<NavigationBloc>().add(ShowViaje());
                    break;
                  case 3:
                    _scaffoldKey.currentState?.openEndDrawer(); // Open Drawer for Profile
                    break;
                }
              },
              items: [
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.home),
                //   label: 'Inicio',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.book),
                //   label: 'Reservas',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.directions_car),
                //   label: 'Viaje',
                // ),
                // BottomNavigationBarItem(
                //   icon: Icon(Icons.person),
                //   label: 'Perfil',
                // ),
                _buildBottomNavigationBarItem(
                  icon: Icons.home, 
                  label: 'Inicio', 
                  isActive: state == NavigationState.inicio
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.book, 
                  label: 'Reservas', 
                  isActive: state == NavigationState.reservas
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.directions_car, 
                  label: 'Viaje', 
                  isActive: state == NavigationState.viaje
                ),
                _buildBottomNavigationBarItem(
                  icon: Icons.person, 
                  label: 'Perfil', 
                  isActive: state == NavigationState.perfil
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavigationBarItem({
    required IconData icon, 
    required String label, 
    required bool isActive
  }) {
    return BottomNavigationBarItem(
      icon: Container(
        width: isActive ? 42 : 24,
        height: isActive ? 42 : 24,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF00A98F) : Colors.transparent,
          shape: BoxShape.circle
        ),
        child: Icon(
          icon, 
          color: isActive ? Colors.white : const Color.fromARGB(255, 111, 111, 111),
          size: isActive ? 30 : 24,
        ),
      ),
      label: label,
      backgroundColor: isActive ? const Color(0xFF00A98F) : Colors.transparent,
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

