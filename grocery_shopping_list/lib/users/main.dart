// import 'dart:js';

import 'package:flutter/material.dart';



import 'user_shop_page.dart';


void main() => runApp(MaterialApp(
      title: 'Navigation demo',
      // initialRoute: '/home',
      // routes: {
      //   '/': (context) => Loading(),
      //   '/home': (context) => Home_pag(),
      //   '/choose_location': (context) => choose_location()
      // },

      home: UserShopPage(),
      

      
    ));

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
    );
  }
}
