import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginState.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/loginContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    // User Screen
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          final response = state.response;
          if (response is ErrorData) {

            // ELIMINAR - ESTA ACA PARA PROBAR EL HOME ANTES DE TENER UN BACKEND ---------------
            // ---------------------------------------------------------------------------------
            Navigator.pushNamedAndRemoveUntil(context, '/passenger/home', (route) => false);
            // ---------------------------------------------------------------------------------
            // ELIMINAR - ESTA ACA PARA PROBAR EL HOME ANTES DE TENER UN BACKEND ---------------

            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG); 
            print('Error Data: ${response.message}');
          } else if (response is Success) {
            final authResponse = response.data as AuthResponse;
            context.read<LoginBloc>().add(SaveUserSession(authResponse: authResponse));

            if (authResponse.user.roles!.length > 1) {
              Navigator.pushNamedAndRemoveUntil(context, 'roles', (route) => false);
            }
            else {
              Navigator.pushNamedAndRemoveUntil(context, '/passenger/home', (route) => false);
            }

            Fluttertoast.showToast(msg: 'Login exitoso', toastLength: Toast.LENGTH_LONG); 
            print('Success Data: ${response.data}');
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            final response = state.response;
            if (response is Loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return LoginContent(state);
          },
        ),
      )
    );
  }
}
