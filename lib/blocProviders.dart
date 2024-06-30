import 'package:carpool_21_app/injection.dart';
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/car-info/carInfoUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/driver-trip-request/driverTripRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/drivers-position/driversPositionUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/geolocation/geolocationUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/passenger-request/passengerRequestUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/reserves/reserveUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/socket/socketUseCases.dart';
import 'package:carpool_21_app/src/domain/useCases/users/userUseCases.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/login/bloc/loginEvent.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerBloc.dart';
import 'package:carpool_21_app/src/screens/pages/auth/register/bloc/registerEvent.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/info/bloc/carInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/list/bloc/carListBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/register/bloc/carRegisterBloc.dart';
import 'package:carpool_21_app/src/screens/pages/carInfo/update/bloc/carUpdateBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/createTrip/bloc/createTripBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/home/bloc/driverHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapLocation/bloc/driverMapLocationBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/tripDetail/bloc/tripDetailBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/tripDetail/bloc/tripDetailEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/home/bloc/passengerHomeBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapBookingInfo/bloc/driverMapBookingInfoBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderBloc.dart';
import 'package:carpool_21_app/src/screens/pages/driver/mapFinder/bloc/driverMapFinderEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserveDetail/bloc/reserveDetailBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserveDetail/bloc/reserveDetailEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/reserves/bloc/reservesEvent.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripAvailableDetail/bloc/tripAvailableDetailBloc.dart';
import 'package:carpool_21_app/src/screens/pages/passenger/tripsAvailable/bloc/tripsAvailableBloc.dart';
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
  BlocProvider<TripsAvailableBloc>(create: (context) => TripsAvailableBloc(locator<AuthUseCases>(), locator<DriversPositionUseCases>(), locator<PassengerRequestsUseCases>())),
  BlocProvider<TripAvailableDetailBloc>(create: (context) => TripAvailableDetailBloc(locator<GeolocationUseCases>(), locator<DriverTripRequestsUseCases>())),
  BlocProvider<ReserveDetailBloc>(create: (context) => ReserveDetailBloc(locator<GeolocationUseCases>(), locator<DriverTripRequestsUseCases>())..add(GetReserveDetail())),
  BlocProvider<ReservesBloc>(create: (context) => ReservesBloc(locator<ReserveUseCases>())..add(GetReservesAll())),


  BlocProvider<DriverHomeBloc>(create: (context) => DriverHomeBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),
  BlocProvider<DriverMapFinderBloc>(create: (context) => DriverMapFinderBloc(locator<GeolocationUseCases>(), locator<SocketUseCases>())..add(DriverMapFinderInitEvent())),
  BlocProvider<DriverMapBookingInfoBloc>(create: (context) => DriverMapBookingInfoBloc(locator<GeolocationUseCases>(), locator<DriverTripRequestsUseCases>())),
  BlocProvider<CreateTripBloc>(create: (context) => CreateTripBloc(locator<AuthUseCases>(), locator<DriverTripRequestsUseCases>())),
  BlocProvider<TripDetailBloc>(create: (context) => TripDetailBloc(locator<GeolocationUseCases>(), locator<DriverTripRequestsUseCases>())..add(GetTripDetail())),
  BlocProvider<DriverMapLocationBloc>(create: (context) => DriverMapLocationBloc(locator<AuthUseCases>(), locator<GeolocationUseCases>(), locator<SocketUseCases>(), locator<DriversPositionUseCases>())),
  
  BlocProvider<ProfileInfoBloc>(create: (context) => ProfileInfoBloc(locator<AuthUseCases>())..add(GetUserInfo())),
  BlocProvider<ProfileUpdateBloc>(create: (context) => ProfileUpdateBloc(locator<AuthUseCases>(), locator<UserUseCases>())),
  
  BlocProvider<CarListBloc>(create: (context) => CarListBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),
  BlocProvider<CarInfoBloc>(create: (context) => CarInfoBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),
  BlocProvider<CarRegisterBloc>(create: (context) => CarRegisterBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),
  BlocProvider<CarUpdateBloc>(create: (context) => CarUpdateBloc(locator<AuthUseCases>(), locator<CarInfoUseCases>())),

  BlocProvider<NavigationBloc>(create: (context) => NavigationBloc(locator<AuthUseCases>())),
  
];