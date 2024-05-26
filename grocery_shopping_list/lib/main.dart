import 'package:flutter/material.dart';
// import 'package:grocery_shopping_list/admin/user_dialog.dart';
import 'package:grocery_shopping_list/presentation/pages/login/login.dart';
import 'package:grocery_shopping_list/presentation/pages/sign_in/signup.dart';
import 'presentation/pages/lists/user_shop_page.dart';
import 'presentation/pages/lists/selectedItems.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'admin/admin_page.dart';
import 'presentation/pages/shops/admin_shops_page.dart';
// import './router/router.dart';
import 'package:go_router/go_router.dart';
import './presentation/pages/lists/user_shop_page2.dart';


void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

// GoRouter configuration
final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Signup(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      path: '/shops',
      builder: (context, state) => AdminShopPage(),
    ),
    GoRoute(
      path: '/userShops',
      builder: (context, state) => UserShopPage(),
    
    )
    // GoRoute(
    //   path: '/',
    //   builder: (context, state) => Signup(),
    // ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      // title: 'My app',
      // home: Signup(),
      // routes: {
      //   '/': (context) => LoginScreen(),
      //   '/signup': (context) => Signup(),
      //   '/shop': (context) => UserShopPage(),
      //   '/login': (context) => LoginScreen(),
      //   '/list': (context) => SellectedItemsPage(selectedItems: [], title: ''),
      // },
    );
  }
}
