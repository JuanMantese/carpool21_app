import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/role.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/car-info/carInfoUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DriverHomeBloc extends Bloc<DriverHomeEvent, DriverHomeState> {

  AuthUseCases authUseCases;
  CarInfoUseCases carInfoUseCases;

  DriverHomeBloc(this.authUseCases, this.carInfoUseCases): super(DriverHomeState()) {
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
    void _setTestUser(GetUserInfo event, Emitter<DriverHomeState> emit) {
      final User testUser = User(
        idUser: 1,
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
      List<CarInfo>? carList;

      // Obteniendo los vehiculos del Driver
      Resource<dynamic> response = await carInfoUseCases.getCarList.run();

      if (response is Success) {
        print('Vehiculos obtenidos');
        carList = response.data as List<CarInfo>;
      } else {
        print('No se lograron obtener los vehiculos');
      }

      // Obteniendo los datos del Driver
      AuthResponse? authResponse = await authUseCases.getUserSession.run();

      if (authResponse != null && authResponse.user != null) {
        print('Datos del usuario obtenidos');
        
        User userData = authResponse.user;
        List<Role> roles = authResponse.user.roles?.map((role) => role).toList() ?? [];

        emit(
          state.copyWith(
            user: userData,
            roles: roles,
            currentUser: authResponse.user,
            userService: event.userService,
            carList: carList
          )
        );
      } else {
         print('Driver Home - AuthResponse es Null');
        _setTestUser(event, emit);
      }
    });
  }
}