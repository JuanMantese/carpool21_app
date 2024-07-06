import 'dart:convert';

import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/authResponse.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;

class AuthService {

  Future<String> token;

  // Constructor
  AuthService(this.token);

  Future<Resource<AuthResponse>> login(String email, String password) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/auth/login'); // Creation of the URL path
      
      Map<String, String> headers = {
        'Content-Type': 'application/json'
      }; // We specify that the information sent is of type JSON
      
      String body = json.encode({
        'email': email,
        'password': password
      });

      // Making the request. I specify the URL, the headers and the body
      final response = await http.post(url, headers: headers, body: body);

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('Data Remote: ${authResponse.toJson()}');
        print('Token: ${authResponse.token}');

        return Success(authResponse);
      } else {
        print('Response status login: ${response.statusCode}');
        print('Response body login: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error login service: $error');
      return ErrorData(error.toString());
    }
  }

  Future<Resource<AuthResponse>> register(User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/auth/register'); // Creation of the URL path
      Map<String, String> headers = {'Content-Type': 'application/json'}; // We specify that the information sent is of type JSON
      String body = json.encode(user);

      // Making the request. I specify the URL, the headers and the body
      final response = await http.post(url, headers: headers, body: body);

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        AuthResponse authResponse = AuthResponse.fromJson(data);
        print('Data register: ${authResponse.toJson()}');
        print('Token register: ${authResponse.token}');

        return Success(authResponse);
      } else {
        print('Response status register: ${response.statusCode}');
        print('Response body register: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error register service: $error');
      return ErrorData(error.toString());
    }
  }

  Future<Resource<User>> changeRol(String idRole) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/users/change-role'); // Creation of the URL path
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${await token}'
      }; // We specify that the information sent is of type JSON

      String body = json.encode(
        {'idRole': idRole}
      );

      // Making the request. I specify the URL, the headers and the body
      final response = await http.patch(url, headers: headers, body: body);

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        User userResponse = User.fromJson(data);
        print('Data changeRol: ${userResponse.toJson()}');

        return Success(userResponse);
      } else {
        print('Response status changeRol: ${response.statusCode}');
        print('Response body changeRol: ${response.body}');
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error changeRol Service: $error');
      return ErrorData(error.toString());
    }
  }

}