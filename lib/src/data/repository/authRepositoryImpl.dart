
import 'package:carpool_21_app/src/data/dataSource/local/sharedPref.dart';
import 'package:carpool_21_app/src/data/dataSource/remote/services/authService.dart';
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/repository/authRepository.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

// Implementation of AuthRepository methods
class AuthRepositoryImpl implements AuthRepository {

  // Instantiating the dependency
  AuthService authService; // Remote Storage
  SharedPref sharedPref; // Local Storage

  // Initializing the dependency in the constructor
  AuthRepositoryImpl(
    this.authService,
    this.sharedPref,
  );

  // implementation login
  @override
  Future<Resource<AuthResponse>> login(String email, String password) {
    return authService.login(email, password);
  }

  // implementation user register
  @override
  Future<Resource<AuthResponse>> register(User user) {
    return authService.register(user);
  }

  // implementation logout
  @override
  Future<bool> logout() async {
    return await sharedPref.remove('user');
  }

  @override
  Future<void> saveUserSession(AuthResponse authResponse) async {
    sharedPref.save('user', authResponse.toJson());
  }

  @override
  Future<AuthResponse?> getUserSession() async {
    final data = await sharedPref.read('user');
    if (data != null) {
      // We interpret the data that comes in JSON format
      AuthResponse authResponse = AuthResponse.fromJson(data);
      return authResponse;
    }
    return null;
  }
}