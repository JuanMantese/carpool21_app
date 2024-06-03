import 'package:carpool_21_app/injection.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/users/userUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerEvent.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapBookingInfo/bloc/passengerMapBookingInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/mapFinder/bloc/passengerMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/bloc/profileUpdateBloc.dart';
import 'package:carpool_21_app/src/screens/pages/roles/bloc/rolesBloc.dart';
import 'package:carpool_21_app/src/screens/pages/roles/bloc/rolesevent.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),
  BlocProvider<PassengerHomeBloc>(create: (context) => PassengerHomeBloc(locator<AuthUseCases>())),
  BlocProvider<PassengerMapFinderBloc>(create: (context) => PassengerMapFinderBloc(locator<GeolocationUseCases>())..add(PassengerMapFinderInitEvent())),
  BlocProvider<PassengerMapBookingInfoBloc>(create: (context) => PassengerMapBookingInfoBloc(locator<GeolocationUseCases>())),
  BlocProvider<DriverHomeBloc>(create: (context) => DriverHomeBloc(locator<AuthUseCases>())),
  
  // BlocProvider<RolesBloc>(create: (context) => RolesBloc(locator<AuthUseCases>())..add(GetRolesList())),
  
  BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<AuthUseCases>(), locator<UserUseCases>())),
  

  BlocProvider<NavigationBloc>(create: (context) => NavigationBloc(locator<AuthUseCases>())),
  
];