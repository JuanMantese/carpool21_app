
// Using local storage to save data
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPref {

  // Saving data - Key: Key value to save
  Future<void> save(String key, dynamic value) async {
    final prefs = await SharedPreferences.getInstance();
    
    // Storing a value in json format
    prefs.setString(key, json.encode(value));
  }

  // Reading session information
  Future<dynamic> read(String key) async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(key) != null) {
      return json.decode(prefs.getString(key)!);
    }
    return null;
  }

  // Removing session information
  Future<bool> remove(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  // Allows you to know if any element exists within the session
  Future<bool> contains(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey(key);
  }

}