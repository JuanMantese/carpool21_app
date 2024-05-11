// navigation_bloc.dart
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationEvent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigationBloc extends Bloc<NavigationEvent, NavigationState> {
  NavigationBloc() : super(NavigationState.inicio) {
    on<NavigationEvent>((event, emit) {
      switch (event) {
        case NavigationEvent.showInicio:
          emit(NavigationState.inicio);
          break;
        case NavigationEvent.showReservas:
          emit(NavigationState.reservas);
          break;
        case NavigationEvent.showViaje:
          emit(NavigationState.viaje);
          break;
        case NavigationEvent.showPerfil:
          emit(NavigationState.perfil);
          break;
      }
    });
  }
}