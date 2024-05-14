// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:carpool_21_app/src/data/dataSource/local/sharedPref.dart'
    as _i3;
import 'package:carpool_21_app/src/data/dataSource/remote/services/authService.dart'
    as _i4;
import 'package:carpool_21_app/src/data/dataSource/remote/services/usersService.dart'
    as _i7;
import 'package:carpool_21_app/src/di/appModule.dart' as _i10;
import 'package:carpool_21_app/src/domain/repository/authRepository.dart'
    as _i5;
import 'package:carpool_21_app/src/domain/repository/usersRepository.dart'
    as _i8;
import 'package:carpool_21_app/src/domain/useCases/auth/authUseCases.dart'
    as _i6;
import 'package:carpool_21_app/src/domain/useCases/users/userUseCases.dart'
    as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final appModule = _$AppModule();
    gh.factory<_i3.SharedPref>(() => appModule.sharedPref);
    gh.factoryAsync<String>(() => appModule.token);
    gh.factory<_i4.AuthService>(() => appModule.authService);
    gh.factory<_i5.AuthRepository>(() => appModule.authRepository);
    gh.factory<_i6.AuthUseCases>(() => appModule.authUseCases);
    gh.factory<_i7.UsersService>(() => appModule.usersService);
    gh.factory<_i8.UsersRepository>(() => appModule.usersRepository);
    gh.factory<_i9.UserUseCases>(() => appModule.userUseCases);
    return this;
  }
}

class _$AppModule extends _i10.AppModule {}
