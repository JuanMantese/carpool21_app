import 'package:carpool_21_app/blocProviders.dart';
import 'package:carpool_21_app/injection.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/login.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/register.dart';
import 'package:carpool_21_app/src/screens/pages/driver/createTrip/createTrip.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/driverHome.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapLocation/driverMapLocation.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/passengerHome.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/driverMapBookingInfo.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/driverMapFinder.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/profileInfo.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/profileUpdate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await configureDependencies();
  runApp(const CarPool21());
}

class CarPool21 extends StatelessWidget {
  const CarPool21({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: blocProviders,
      child: MaterialApp(
        builder: FToastBuilder(),
        title: 'Carpool 21',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
          // '/roles': (context) => const RolesPage(), // ELIMINAR - Por ahora lo utilizo, pero vamos a manejar el cambio de roles desde el Drawer
          '/profile': (context) => const ProfileInfoPage(),
          '/profile/update': (context) => const ProfileUpdatePage(),
          '/passenger/home': (context) => const PassengerHomePage(),
          '/driver/home': (context) => const DriverHomePage(),
          '/driver/finder': (context) => const DriverMapFinder(),
          '/driver/map/booking': (context) => const DriverMapBookingInfo(),
          '/driver/createTrip': (context) => const CreateTripPage(),
          '/passenger/location': (context) => const DriverMapLocation(),
        },
        // home: const LoginPage()
      ),
    );
  }
}
