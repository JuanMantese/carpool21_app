// navigation_bloc.dart
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {


  AuthUseCases authUseCases;

  NavigationBloc(this.authUseCases) : super(NavigationState.inicio) {
    on<NavigationEvent>((event, emit) {
      if (event is ShowInicio) {
        emit(NavigationState.inicio);
      } else if (event is ShowReservas) {
        emit(NavigationState.reservas);
      } else if (event is ShowViaje) {
        emit(NavigationState.viaje);
      } else if (event is ShowPerfil) {
        emit(NavigationState.perfil);
      }
    });

    on<Logout>((event, emit) async {
      await authUseCases.logout.run();
    });
  }
}