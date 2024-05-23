
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/signup_service.dart';
import '../presentation/pages/login/login.dart';

final apiServiceProvider = Provider<ApiService>((ref) => ApiService());

final authProvider =
    Provider((ref) => AuthState(ref.watch(apiServiceProvider)));

class AuthState {
  final ApiService _apiService;

  AuthState(this._apiService);

  Future<void> signUp(String username, String password, String role, context) async {
    await _apiService.signUp(username, password, role, context);
    // Add logic to handle signup success (e.g., navigate to home screen)
    // Navigator.push(BuildContext context LoginScreen());
  }
}

// class AdminState extends Provider<bool> {
//   // AdminState() : super(false); // Default value is false

//   void toggleAdmin() {
//     state = !state;
//   }
// }

// final adminProvider = Provider<AdminState>((ref) {
//   return AdminState();
// });

// final adminServiceProvider = Provider<AdminService>((ref) => AdminService());

// final adminProvider =
//     Provider((ref) => AuthState(ref.watch(apiServiceProvider)));

// class AdminState {
//   final AdminService _adminService;

//   AdminState(this._adminService);

//    void toggleAdmin(state) {
//     state = !state;
//   }
// }
