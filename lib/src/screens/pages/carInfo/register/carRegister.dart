import 'package:carpool_21_app/src/domain/models/carInfo.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterEvent.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterState.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/carRegisterContent.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class CarRegisterPage extends StatefulWidget {
  const CarRegisterPage({super.key});

  @override
  State<CarRegisterPage> createState() => _CarRegisterPageState();
}

class _CarRegisterPageState extends State<CarRegisterPage> with RouteAware {

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

  // Observamos cual es la ruta anterior
  String previousRoute = '';

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)! as PageRoute);
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPush() {
    super.didPush();
    // This method is called when the current route has been pushed.
    // You can get the previous route here.
    if (ModalRoute.of(context)!.settings.arguments != null) {
      previousRoute = ModalRoute.of(context)!.settings.arguments as String;
    }
  }

  // Secondary execution: Triggered every time we make a state change in a widget on that screen
  @override
  Widget build(BuildContext context) {
    print('Previous Route: $previousRoute');

    return Scaffold(
      body: BlocListener<CarRegisterBloc, CarRegisterState>(
        listener: (context, state) {
          final response = state.response; 
          if (response is ErrorData) {
            Fluttertoast.showToast(msg: response.message, toastLength: Toast.LENGTH_LONG); 
            print('Error Data: ${response.message}');
          } else if (response is Success) {
            print('Success Data: ${response.data}');

            Fluttertoast.showToast(msg: 'Registro exitoso', toastLength: Toast.LENGTH_LONG); 
            CarInfo carInfo = response.data;
            
            // Actualizamos la información local del usuario
            context.read<CarRegisterBloc>().add(UpdateUserSession());

            Navigator.pushNamedAndRemoveUntil(context, '/car/info', (route) => false,
              arguments: {
                'idVehicle': carInfo.idVehicle,
                'originPage': previousRoute
              }
            );
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
