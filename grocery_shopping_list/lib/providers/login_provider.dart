// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import '../presentation/pages/shops/admin_shops_page.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';
// import 'package:grocery_shopping_list/main.dart';

// final authoProvider = Provider((ref) => AuthService());

// class AuthService {
//   Future<bool> setToken(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString('token', value);
//   }

//   Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   Future<String?> login(String username, String password, context) async {
//     final response = await http.post(
//       Uri.parse('http://localhost:6036/auth/login'),
//       body: {'username': username, 'password': password},
//     );

//     if (response.statusCode == 201) {
//       // Successful login, extract the token
//       // final Map<String, dynamic> data = json.decode(response.body)
//       // ;

//       // context.go('/shops');

//       final token = response.body;
//       print(token);

//       // setToken(token);

//       // final prefs = await SharedPreferences.getInstance();
//       // await prefs.setString('access_token', token);
//       // Store the token securely (e.g., using secure storage)
//       // For simplicity, you can use shared preferences
//       // Here we are printing the token
//       // print('Access pref: $prefs');
//       return token;
//     } else {
//       // Login failed
//       throw Exception('Failed to login');
//     }
//   }
// }

//////////////////////////////////

// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:go_router/go_router.dart';
// import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

// final authoProvider = Provider((ref) => AuthService());

// class AuthService {
//   Future<bool> setToken(String value) async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.setString('access_token', value);
//   }

//   Future<String?> getToken() async {
//     final SharedPreferences prefs = await SharedPreferences.getInstance();
//     return prefs.getString('access_token');
//   }

//   Future<void> login(
//       String username, String password, BuildContext context) async {
//     try {
//       final response = await http.post(
//         Uri.parse('http://localhost:6036/auth/login'),
//         body: {'username': username, 'password': password},
//       );

//       if (response.statusCode == 201) {
//         final token = response.body;
//         await setToken(token);
//         print('Token stored in SharedPreferences');

//         final role = _decodeRoleFromToken(token);
//         _navigateToRolePage(role, context);
//       } else {
//         throw Exception('Failed to login');
//       }
//     } catch (e) {
//       print('Error: $e');
//       throw Exception('Network error: Failed to login');
//     }
//   }

//   String _decodeRoleFromToken(String token) {
//     final jwt = JWT.decode(token);
//     print(jwt);
//     return jwt.payload['role']; // Adjust based on your token's structure
//   }

//   void _navigateToRolePage(String role, BuildContext context) {
//     if (role == 'admin') {
//       context.go('/admin');
//     } else if (role == 'user') {
//       context.go('/user');
//     } else {
//       throw Exception('Unknown role');
//     }
//   }
// }

/////////////////////////

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

final authoProvider = Provider((ref) => AuthService());

class AuthService {
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('access_token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<bool> setID(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('id', value);
  }

  Future<String?> getID() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('id');
  }

  Future<void> login(
      String username, String password, BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:6036/auth/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> responseBody = jsonDecode(response.body);
        final token = responseBody['access_token'];
        final userId = responseBody['id'];

        await setToken(token);
        await setID(userId);
        print(token);

        final role = _decodeRoleFromToken(token);
        _navigateToRolePage(role, context);
      } else {
        throw Exception('Failed to login');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Network error: Failed to login');
    }
  }

  String _decodeRoleFromToken(String token) {
    try {
      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      return decodedToken['role']; // Adjust based on your token's structure
    } catch (e) {
      throw Exception('Failed to decode token');
    }
  }

  // String _decodeIDFromToken(String token) {
  //   try {
  //     Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
  //     return decodedToken['sub']; // Adjust based on your token's structure
  //   } catch (e) {
  //     throw Exception('Failed to decode token');
  //   }
  // }

  void _navigateToRolePage(String role, BuildContext context) {
    if (role == 'admin') {
      context.go('/shops');
    } else if (role == 'user') {
      context.go('/userShops');
    } else {
      throw Exception('Unknown role');
    }
  }
}
