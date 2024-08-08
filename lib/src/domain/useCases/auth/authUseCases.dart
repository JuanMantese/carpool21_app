import 'package:carpool_21_app/src/domain/useCases/auth/changeRolUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/getUserSessionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/loginUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/logoutUseCase.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/registerUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/saveUserSessionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/updateUserSessionUseCase.dart';

class AuthUseCases {

  LoginUseCase login;
  LogoutUseCase logout;
  RegisterUseCase register;
  ChangeRolUseCase changeRolUseCase;
  SaveUserSessionUseCase saveUserSession;
  UpdateUserSessionUseCase updateUserSession;
  GetUserSessionUseCase getUserSession;

  AuthUseCases({
    required this.login,
    required this.logout,
    required this.register,
    required this.changeRolUseCase,
    required this.saveUserSession,
    required this.updateUserSession,
    required this.getUserSession,
  });

}