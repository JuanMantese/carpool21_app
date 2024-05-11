import 'package:carpool_21_app/src/domain/useCases/auth/getUserSessionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/loginUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/registerUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/saveUserSessionUseCases.dart';

class AuthUseCases {

  LoginUseCase login;
  LogoutUseCase logout;
  RegisterUseCase register;
  SaveUserSessionUseCase saveUserSession;
  GetUserSessionUseCase getUserSession;

  AuthUseCases({
    required this.login,
    required this.logout,
    required this.register,
    required this.saveUserSession,
    required this.getUserSession,
  });

}