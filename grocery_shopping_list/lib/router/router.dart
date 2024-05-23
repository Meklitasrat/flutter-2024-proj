import 'package:go_router/go_router.dart';
import '../presentation/pages/sign_in/signup.dart';

// GoRouter configuration
final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Signup(),
    ),
  ],
);