
import 'package:carpool_21_app/src/data/dataSource/local/sharedPref.dart';
import 'package:carpool_21_app/src/data/dataSource/remote/services/authService.dart';
import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/data/repository/authRepositoryImpl.dart';
import 'package:carpool_21_app/src/data/repository/geolocationRepositoryImpl.dart';
import 'package:carpool_21_app/src/data/repository/usersRepositoryImpl.dart';
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/repository/authRepository.dart';
import 'package:carpool_21_app/src/domain/repository/geolocationRepository.dart';
import 'package:carpool_21_app/src/domain/repository/usersRepository.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/getUserSessionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/loginUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/registerUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/saveUserSessionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/createMarkerUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/findPositionUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/getMarkerUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/getPlacemarkDataUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/users/updateUserUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/users/userUseCases.dart';
import 'package:injectable/injectable.dart';


// Here I place all the dependencies that I am going to use in the project
@module
abstract class AppModule {

  @injectable
  SharedPref get sharedPref => SharedPref();  // Local Storage

  @injectable
  Future<String> get token async {  // User Access Token
    String token = '';
    final userSession = await sharedPref.read('user');
    if (userSession != null) {
      AuthResponse authResponse = AuthResponse.fromJson(userSession);
      token = authResponse.token;
    }
    return token;
  }

  @injectable
  AuthService get authService => AuthService(); // Remote Storage

  @injectable
  AuthRepository get authRepository => AuthRepositoryImpl(authService, sharedPref);

  @injectable
  AuthUseCases get authUseCases => AuthUseCases(
    login: LoginUseCase(authRepository),
    logout: LogoutUseCase(authRepository),
    register: RegisterUseCase(authRepository),
    saveUserSession: SaveUserSessionUseCase(authRepository),
    getUserSession: GetUserSessionUseCase(authRepository),
  );


  @injectable
  UsersService get usersService => UsersService(token); // Service User

  @injectable
  UsersRepository get usersRepository => UsersRepositoryImpl(usersService);

  @injectable
  UserUseCases get userUseCases => UserUseCases(
    update: UpdateUserUseCase(usersRepository),
  );

  // Geolocation Repository
  @injectable
  GeolocationRepository get geolocationRepository => GeolocationRepositoryImpl();

  @injectable
  GeolocationUseCases get geolocationUseCases => GeolocationUseCases(
    findPosition: FindPositionUseCase(geolocationRepository),
    createMarker: CreateMarkerUseCase(geolocationRepository),
    getMarker: GetMarkerUseCase(geolocationRepository),
    getPlacemarkData: GetPlacemarkDataUseCase(geolocationRepository),

  );
}
