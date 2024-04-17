import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Authentication/signup.dart';
// import 'package:flutter_application_1/JsonModels/users.dart';
// import 'package:flutter_application_1/SQLite/sqlite.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = false;
  // bool isLoginTrue = false;

  // final db = DatabaseHelper();

  // login() {
  //   var response =
  //       db.login(Users(usrName: username.text, usrPassword: password.text));
  //   if (response == true) {
  //     Navigator.push(context, MaterialPageRoute(builder: (context) => Notes()));
  //   } else {
  //     setState(() {
  //       isLoginTrue = true;
  //     });
  //   }
  // }

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
              Image.asset('lib/assets/picture.png', width: 210),
              const ListTile(
                  title: Text("Welcome back,",
                      style: TextStyle(
                          fontSize: 30, fontWeight: FontWeight.bold))),
              const SizedBox(height: 15),
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(0.2)),
                child: TextFormField(
                    controller: username,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Username is required!";
                      }
                      return null;
                    },
                    decoration: const InputDecoration(
                      icon: Icon(Icons.person),
                      border: InputBorder.none,
                      hintText: "Username",
                    )),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.deepPurple.withOpacity(0.2)),
                child: TextFormField(
                    controller: password,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password is required!";
                      }
                      return null;
                    },
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
                      },
                    
                    child:
                        Text("LOGIN", style: TextStyle(color: Colors.white))),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Signup()));
                    },
                    child: const Text('SIGN UP'),
                  )
                ],
              ),
                  const Text(
                      "username or password is incorrect",
                      style: TextStyle(color: Colors.red),
                    ),
                  SizedBox(),
                
            ],
          ),
        ),
      ),
      ),
    ),
    );
  }
}
