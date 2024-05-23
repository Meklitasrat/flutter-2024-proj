import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../presentation/pages/shops/admin_shops_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:go_router/go_router.dart';

final authoProvider = Provider((ref) => AuthService());

class AuthService {
  Future<bool> setToken(String value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', value);
  }

  Future<String?> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('access_token');
  }

  Future<String?> login(String username, String password, context) async {
    final response = await http.post(
      Uri.parse('http://localhost:6036/auth/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 201) {
      // Successful login, extract the token
      // final Map<String, dynamic> data = json.decode(response.body);
      final token = response.body;
      print(token);

      setToken(token);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', token);
      // Store the token securely (e.g., using secure storage)
      // For simplicity, you can use shared preferences
      // Here we are printing the token
      print('Access pref: $prefs');
      context.go('/shops');
      return token;
    } else {
      // Login failed
      throw Exception('Failed to login');
    }
  }
}
