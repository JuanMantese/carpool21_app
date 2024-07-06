import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/info/bloc/carInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/info/bloc/carInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterEvent.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterState.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/carRegisterContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CarRegisterPage extends StatefulWidget {
  const CarRegisterPage({super.key});

  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> {
  User? user;

  // Initial execution - First event to fire when the screen first appears - Runs only once
  @override
  void initState() {
    super.initState();

    // Wait until all elements of the Widget build are loaded to execute the Event
    // This is done to prevent the carInfo from coming in as null, as it is instantiated in the Widget build
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<CarRegisterBloc>().add(CarRegisterInitEvent());
    });
  }

  // Secondary execution: Triggered every time we make a state change in a widget on that screen
  @override
  Widget build(BuildContext context) {
    // ELIMINAR - PERMITO EL VALOR NULL - Eliminar esto cuando tengamos el Back
    user = ModalRoute.of(context)?.settings.arguments as User?;
    // user = ModalRoute.of(context)?.settings.arguments as User; DESCOMENTAR

    return Scaffold(
      body: BlocListener<CarRegisterBloc, CarRegisterState>(
        listener: (context, state) {
          final response = state.response; 
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG); 
            print('Error Data: ${response.message}');
          } else if (response is Success) {
            Fluttertoast.showToast(msg: 'Registro exitoso', toastLength: Toast.LENGTH_LONG); 
            print('Success Data: ${response.data}');

            // Updating carInfoData on screen - I wait 1s for the in-session update to finish
            // Future.delayed(const Duration(seconds: 1), () {
            //   context.read<CarInfoBloc>().add(GetCarInfo());
            // });

            Navigator.pushNamedAndRemoveUntil(context, '/car/info', (route) => false);

            // Navigator.pushNamedAndRemoveUntil(context, '/passenger/home', (route) => false);   // REVISAR o ELIMINAR
            // Navigator.pop(context);
          }
        },
        child: BlocBuilder<CarRegisterBloc, CarRegisterState>(
          builder: (context, state) {
            final response = state.response; 
            if (response is Loading) {
              // We display the content and the Loading
              return Stack(
                children: [
                  CarRegisterContent(state),
                  const Center(child: CircularProgressIndicator())
                ],
              );
            } 

            return CarRegisterContent(state);
          },
        ),
      ),
    );
  }
}
