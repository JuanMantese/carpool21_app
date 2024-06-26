import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/role.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PassengerHomeBloc extends Bloc<PassengerHomeEvent, PassengerHomeState> {

  AuthUseCases authUseCases;

  PassengerHomeBloc(this.authUseCases): super(PassengerHomeState()) {
    on<ChangeDrawerPage>((event, emit) {
      emit(
        state.copyWith(
          pageIndex: event.pageIndex
        )
      );
    });

    // on<Logout>((event, emit) async {
    //   await authUseCases.logout.run();
    // });


    // Usuario de prueba - Logica para obtener todos los datos del usuario
    void _setTestUser(GetUserInfo event, Emitter<PassengerHomeState> emit) {
      final User testUser = User(
        id: 1,
        name: 'Juan',
        lastName: 'Mantese',
        studentFile: 'SOF01669',
        dni: 12345678,
        phone: 3517872662,
        address: '123 Calle Falsa',
        email: 'juan.mantese@example.com',
        password: 'password123',
        passwordConfirm: 'password123',
        contactName: 'Franco',
        contactLastName: 'Jara',
        contactPhone: 3513751312,
        photoUser: 'lib/assets/img/profile-icon.png',
        notificationToken: null,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        roles: [
          Role(
            idRole: "ADMIN",
            name: "Administrador",
            route: "/roles/admin",
          ),
          Role(
            idRole: "PASSENGER",
            name: "Pasajero",
            route: "/roles/passenger",
          ),
        ],
      );

      emit(state.copyWith(
        roles: testUser.roles?.map((role) => role).toList(),
        currentUser: testUser,
        userService: event.userService,
      ));
    }

    on<GetUserInfo>((event, emit) async {
      AuthResponse? authResponse = await authUseCases.getUserSession.run();

      if (authResponse != null && authResponse.user != null) {
        print('Datos del usuario obtenidos - Passenger');
        
        List<Role> roles = authResponse.user.roles?.map((role) => role).toList() ?? [];
        
        emit(
          state.copyWith(
            roles: roles,
            currentUser: authResponse.user,
            userService: event.userService,
          )
        );
      } else {
        print('No entro en GetUserInfo - Passenger');
        _setTestUser(event, emit);
      }
    });
  }

}