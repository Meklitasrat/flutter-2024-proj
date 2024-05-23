import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../presentation/pages/login/login.dart';
import '../presentation/pages/sign_in/signup.dart';



class ApiService {
  // static const baseUrl = 'http://your_api_endpoint/user';

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

    if (response.statusCode == 201) {
      // Handle successful signup
     context.go('/login');
      
    } else {
      // Handle signup failure
      throw Exception(FlutterError.presentError);
    }
  }
}
