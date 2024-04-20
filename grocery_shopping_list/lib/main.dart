import 'package:flutter/material.dart';
import 'package:grocery_shopping_list/admin/user_dialog.dart';
import 'package:grocery_shopping_list/presentation/pages/login/login.dart';
import 'package:grocery_shopping_list/presentation/pages/sign_in/signup.dart';
import './users/user_shop_page.dart';
import './users/selectedItems.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => Signup(),
        '/shop': (context) => UserShopPage(),
        '/login': (context) => LoginScreen(),
        '/list': (context) => SellectedItemsPage(selectedItems: [], title: ''),
      },
    );
  }
}
