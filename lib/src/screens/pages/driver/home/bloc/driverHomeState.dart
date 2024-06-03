import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart';
import 'package:carpool_21_app/src/domain/models/role.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:equatable/equatable.dart';

class DriverHomeState extends Equatable {
  
  final int pageIndex;

  // Obteniendo toda la informacion de sesion del usuario
  final List<Role>? roles;
  final User? currentUser;
  final UsersService? userService;

  DriverHomeState({
    this.pageIndex = 0,
    this.roles,
    this.currentUser,
    this.userService,
  });

  DriverHomeState copyWith({
    int? pageIndex,
    List<Role>? roles,
    User? currentUser,
    UsersService? userService,
  }) {
    return DriverHomeState(
      pageIndex: pageIndex ?? this.pageIndex,
      roles: roles ?? this.roles,
      currentUser: currentUser ?? this.currentUser,
      userService: userService ?? this.userService,
    );
  }

  List<Object?> get props => [pageIndex];

}