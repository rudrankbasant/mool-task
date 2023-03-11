import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mool_task/data/model/signup_user.dart';
import 'package:mool_task/data/model/user_response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../utils/constants.dart';
import '../model/login_response.dart';
import '../model/signup_response.dart';

class UsersRepo {

  Future<List<UserResponse>> fetchAllUsers() async {
    List<UserResponse> allUsers = [];

    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwtToken');
    if(token==null) throw Exception("Token not found");
    final response = await http.get(
        Uri.parse('$BASE_URL/users/'),
        headers: {
          "accept": "application/json",
          "Authorization": "Bearer $token"
        });

    if (response.statusCode < 300) {
      debugPrint("here is the response: ${response.body}");
      List<dynamic> myMap =  json.decode(response.body);
      debugPrint("here is the map: $myMap");
      if (myMap.isNotEmpty) {
        for (var i = 0; i < myMap.length; i++) {
          allUsers.add(UserResponse.fromJson(myMap[i]));
        }
      }
      return allUsers;
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      debugPrint(response.body);
      throw Exception('Failed to fetch (login)');
    }
  }

  void updateUser() async {

  }

  void deleteUser() async {

  }
}