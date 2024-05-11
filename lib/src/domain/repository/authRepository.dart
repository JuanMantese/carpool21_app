
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';

// We define the business logic
abstract class AuthRepository {
  Future<Resource<AuthResponse>> login(String email, String password);
  Future<Resource<AuthResponse>> register(User user);
  Future<bool> logout();

  // Save user session in local storage
  Future<void> saveUserSession(AuthResponse authResponse);

  // Obtaining user session from local storage
  Future<AuthResponse?> getUserSession();
}