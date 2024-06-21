import 'dart:io';
import 'dart:convert';
import 'package:carpool_21_app/src/data/api/apiConfig.dart';
import 'package:carpool_21_app/src/domain/models/user.dart';
import 'package:carpool_21_app/src/domain/utils/listToString.dart';
import 'package:carpool_21_app/src/domain/utils/resource.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path/path.dart';

class UsersService {

  Future<String> token;

  // Constructor
  UsersService(this.token);

  // To update a user's data, we need the Session Token
  Future<Resource<User>> update(int id, User user) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/users/$id'); // Creation of the URL path
      
      Map<String, String> headers = {
        'Content-Type': 'application/json',
        'Authorization': await token
      }; // We specify that the information sent is of type JSON
      
      String body = json.encode({
        'name': user.name,
        'lastName': user.lastName, 
        'studentFile': user.studentFile,
        'dni': user.dni,
        'phone': user.phone,
        'address': user.address,
        'contactName': user.contactName,
        'contactLastName': user.contactLastName,
        'contactPhone': user.contactPhone,
      });

      // Making the request. I specify the URL, the headers and the body
      final response = await http.put(url, headers: headers, body: body);

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        User userResponse = User.fromJson(data);
        print('Data Remote: ${user.toJson()}');

        return Success(userResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error: $error');
      return ErrorData(error.toString());
    }
  }


  // Update with Image
  Future<Resource<User>> updateImage(int id, User user, File image) async {
    try {
      Uri url = Uri.http(ApiConfig.API_CARPOOL21, '/users/upload/$id'); // Creation of the URL path
      
      final request = http.MultipartRequest('PUT', url); // Build the request

      request.headers['Authorization'] = await token; // Define the header

      // Assembling the file that we are going to send to the back
      request.files.add(http.MultipartFile(
        'file',  // Identifier that we define in the backend
        http.ByteStream(image.openRead().cast()),
        await image.length(), // File size
        filename: basename(image.path),  // File Name
        contentType: MediaType('image', 'jpg') // Indicate what we are going to upload, and what type of file it is
      ));

      // Assemble the body with the fields that we are going to send
      request.fields['name'] = user.name;
      request.fields['lastname'] = user.lastName;
      // request.fields['studentFile'] = user.studentFile;
      request.fields['dni'] = user.dni.toString();
      request.fields['phone'] = user.phone.toString();
      request.fields['address'] = user.address;
      request.fields['contactName'] = user.contactName;
      request.fields['contactLastName'] = user.contactLastName;
      request.fields['contactPhone'] = user.contactPhone.toString();

      // Send request
      final response = await request.send();

      // Decoding the information to be able to interpret it in Dart
      final data = json.decode(await response.stream.transform(utf8.decoder).first);

      if (response.statusCode == 200 || response.statusCode == 201) {
        User userResponse = User.fromJson(data);
        return Success(userResponse);
      } else {
        return ErrorData(listToString(data['message']));
      }
    } catch (error) {
      print('Error: $error');
      return ErrorData(error.toString());
    }
  }

}