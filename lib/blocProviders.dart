import 'package:carpool_21_app/injection.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/car-info/carInfoUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/driverTripRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/drivers-position/driversPositionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/socket/socketUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/users/userUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerEvent.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/info/bloc/carInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/update/bloc/carUpdateBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/createTrip/bloc/createTripBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapLocation/bloc/driverMapLocationBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/profile/info/bloc/profileInfoEvent.dart';
import 'package:carpool_21_app/src/screens/pages/profile/update/bloc/profileUpdateBloc.dart';
import 'package:carpool_21_app/src/screens/widgets/navigation/bloc/navigationBloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

List<BlocProvider> blocProviders = [
  BlocProvider<LoginBloc>(create: (context) => LoginBloc(locator<AuthUseCases>())..add(LoginInitEvent())),
  BlocProvider<RegisterBloc>(create: (context) => RegisterBloc(locator<AuthUseCases>())..add(RegisterInitEvent())),
  // BlocProvider<RolesBloc>(create: (context) => RolesBloc(locator<AuthUseCases>())..add(GetRolesList())),
  
  BlocProvider<PassengerHomeBloc>(create: (context) => PassengerHomeBloc(locator<AuthUseCases>())),
  
  BlocProvider<DriverMapFinderBloc>(create: (context) => DriverMapFinderBloc(locator<GeolocationUseCases>(), locator<SocketUseCases>())..add(DriverMapFinderInitEvent())),
  BlocProvider<DriverMapBookingInfoBloc>(create: (context) => DriverMapBookingInfoBloc(locator<GeolocationUseCases>(), locator<DriverTripRequestsUseCases>())),
  BlocProvider<DriverHomeBloc>(create: (context) => DriverHomeBloc(locator<AuthUseCases>())),
  BlocProvider<DriverMapLocationBloc>(create: (context) => DriverMapLocationBloc(locator<AuthUseCases>(), locator<GeolocationUseCases>(), locator<SocketUseCases>(), locator<DriversPositionUseCases>())),
  BlocProvider<CreateTripBloc>(create: (context) => CreateTripBloc(locator<AuthUseCases>(), locator<DriverTripRequestsUseCases>())),
  
  BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<AuthUseCases>(), locator<UserUseCases>())),
  
  BlocProvider<CarInfoBloc>(create: (context) => CarInfoBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),
  BlocProvider<CarRegisterBloc>(create: (context) => CarRegisterBloc(locator<AuthUseCases>())),
  BlocProvider<CarUpdateBloc>(create: (context) => CarUpdateBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),



  BlocProvider<NavigationBloc>(create: (context) => NavigationBloc(locator<AuthUseCases>())),
  
];