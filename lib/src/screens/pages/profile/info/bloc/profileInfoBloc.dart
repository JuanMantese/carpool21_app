import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/role.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoState.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileInfoBloc extends Bloc<ProfileInfoEvent, ProfileInfoState> {

  AuthUseCases authUseCases;

  // Constructor
  ProfileInfoBloc(this.authUseCases): super(ProfileInfoState()) {
    
    void _setTestUser(GetUserInfo event, Emitter<ProfileInfoState> emit) {
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
        user: testUser,
      ));
    }

    on<GetUserInfo>((event, emit) async {
      //DESCOMENTAR
      // Obtaining session information
      // AuthResponse authResponse = await authUseCases.getUserSession.run();

      // Issuing the information to use it - DESCOMENTAR
      // emit(
      //   state.copyWith(
      //     user: authResponse.user
      //   )
      // );
      // HASTA ACA ---------

      try {
        AuthResponse authResponse = await authUseCases.getUserSession.run();
        
        if (authResponse != null && authResponse.user != null) {
          emit(
            state.copyWith(
              user: authResponse.user,
            )
          );
        } else {
          print('Entro en 2');
          _setTestUser(event, emit);
        }
      } catch (e) {
        _setTestUser(event, emit);
    
      }
    }); 
  }

}