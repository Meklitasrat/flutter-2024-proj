import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:http/http.dart' as http;
import '../presentation/pages/login/login.dart';
import '../presentation/pages/sign_in/signup.dart';
import '../main.dart';

class ApiService {
  // final GoRouter _router;
  Future signUp(String username, String password, String role, context) async {
    // if (isAdmin == true) {
    //   role = 'admin';
    // }
    final response = await http.post(
      Uri.parse('http://localhost:6036/user/signup'),
      body: {
        'username': username,
        'password': password,
        'role': role,
      },
    );

    // return response;

    if (response.statusCode == 201) {
      // Handle successful signup
      // context.push('/login');
      // Navigator.push(context,
      //     MaterialPageRoute(builder: (BuildContext context) => LoginScreen()));

      return true;
    } else {
      // Handle signup failure
      // throw Exception(FlutterError.presentError);
      return false;
    }
  }

  Future logout(context) async {
    final response = await http.post(
      Uri.parse('http://localhost:6036/auth/logout'),
    );
    if (response.statusCode == 201) {
      // Handle successful signup
      context.go('/login');
    } else {
      // Handle signup failure
      throw Exception(FlutterError.presentError);
    }
  }
}
