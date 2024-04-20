import 'package:flutter/material.dart';
import '../sign_in/signup.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isVisible = false;

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  // Image.asset('../assets/picture.png', width: 210),
                  const ListTile(
                      title: Text("Welcome back,",
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold))),
                  const SizedBox(height: 15),
                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2)),
                    child: TextFormField(
                        decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username",
                    )),
                  ),

                  Container(
                    margin: const EdgeInsets.all(10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(0.2)),
                    child: TextFormField(
                        obscureText: isVisible,
                        decoration: InputDecoration(
                            icon: const Icon(Icons.lock),
                            border: InputBorder.none,
                            hintText: "Password",
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: Icon(isVisible
                                    ? Icons.visibility
                                    : Icons.visibility_off)))),
                  ),
                  const SizedBox(height: 10),

                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/shop');
                        },
                        child: const Text("LOGIN",
                            style: TextStyle(color: Colors.white))),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?"),
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/signup');
                        },
                        child: const Text('SIGN UP'),
                      )
                    ],
                  ),
                  const Text(
                    "username or password is incorrect",
                    style: TextStyle(color: Colors.red),
                  ),
                  // SizedBox(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
