
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginState.dart';
import 'package:carpool_21_app/src/screens/utils/blocFormItem.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  AuthUseCases authUseCases;

  final formKey = GlobalKey<FormState>();

  // constructor
  LoginBloc(
    this.authUseCases,
  ): 
  super(const LoginState()) {
    
    // First event that is executed when the app starts
    on<LoginInitEvent>((event, emit) async {
      // Getting session information
      AuthResponse? authResponse = await authUseCases.getUserSession.run();
      print('Auth Response: ${authResponse?.toJson()}');

      emit(state.copyWith(formKey: formKey));

      // If the user closes and reopens the app, I check if they are logged in so as not to request access again
      if (authResponse != null) {
        emit(
          state.copyWith(
            response: Success(authResponse),
            formKey: formKey
          )
        );
      }
    });

    on<EmailChanged>((event, emit) {
      // event.emailInput What the user is writing in the input
      emit(
        state.copyWith(
          email: BlocFormItem(
            value: event.emailInput.value,
            error: event.emailInput.value.isEmpty ? 'Ingresa su email' : null
          ),
          formKey: formKey
        )
      );
    });

    on<PasswordChanged>((event, emit) {
      emit(
        state.copyWith(
          password: BlocFormItem(
            value: event.passwordInput.value,
            error: event.passwordInput.value.isEmpty 
              ? 'Ingresa tu contrasena'
              : event.passwordInput.value.length < 6
                ? 'Minimo 6 caracteres' : null 
          ),
          formKey: formKey
        )
      );
    });

    on<FormSubmit>((event, emit) async {
      print('Email: ${ state.email.value }');
      print('Password: ${ state.password.value }');

      // Issuance of status change - Loading
      emit(
        state.copyWith(
          response: Loading(),
          formKey: formKey
        )
      );

      // PARA QUE APAREZCA El estado de Loading (circle) - Tirar el Back y que quede cargando
      Resource response = await authUseCases.login.run(state.email.value, state.password.value);

      // Issuance of status change - Success/Error
      emit(
        state.copyWith(
          response: response,
          formKey: formKey
        )
      );

    });

    on<SaveUserSession>((event, emit) async {
      await authUseCases.saveUserSession.run(event.authResponse);
    });

  }
}