import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/domain/models/role.dart';
import 'package:carpool_21_app/src/domain/models/tripDetail.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/screens/utils/globals.dart';
import 'package:equatable/equatable.dart';

class PassengerHomeState extends Equatable {
  
  final int pageIndex;

  // Obteniendo toda la informacion de sesion del usuario
  final List<Role>? roles;
  final User? currentUser;
  final UsersService? userService;
  final TripDetail? currentReserve;

  PassengerHomeState({
    this.pageIndex = 0,
    this.roles,
    this.currentUser,
    this.userService,
    this.currentReserve,
  });

  PassengerHomeState copyWith({
    int? pageIndex,
    List<Role>? roles,
    User? currentUser,
    UsersService? userService,
    TripDetail? currentReserve,
  }) {
    return PassengerHomeState(
      pageIndex: pageIndex ?? this.pageIndex,
      roles: roles ?? this.roles,
      currentUser: currentUser ?? this.currentUser,
      userService: userService ?? this.userService,
      currentReserve: currentReserve ?? this.currentReserve
    );
  }
  
  @override
  List<Object?> get props => [pageIndex, roles, currentRole, userService, currentReserve];

}