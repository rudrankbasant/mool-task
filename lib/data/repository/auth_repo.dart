import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:mool_task/data/model/signup_user.dart';
import '../../utils/constants.dart';
import '../model/login_response.dart';
import '../model/signup_response.dart';

class AuthRepo {

  Future<SignUpResponse> signup(SignupUser user) async {

    final response = await http.post(
        Uri.parse('$BASE_URL/signup'),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body: {"fullname": user.fullname, "username": user.username, "password": user.password, "email": user.email});

    if (response.statusCode < 300) {
      return SignUpResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      final jsonError = jsonDecode(response.body);
      debugPrint(jsonError['detail']);
      throw Exception(jsonError['detail']);
    }
  }

  Future<LoginResponse> login(String username, String pwd) async {

    final response = await http.post(
        Uri.parse('$BASE_URL/login'),
        headers: {
          "accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        encoding: Encoding.getByName('utf-8'),
        body:{'username': username, 'password': pwd});

    if (response.statusCode < 300) {
      debugPrint(response.body);
      return LoginResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 404) {
      throw Exception("Not registered");
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      final jsonError = jsonDecode(response.body);
      debugPrint(jsonError['detail']);
      throw Exception(jsonError['detail']);
    }
  }
}