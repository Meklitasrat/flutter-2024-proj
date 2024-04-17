import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/Authentication/login.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = true;
  bool isAdmin = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const ListTile(
                    title: Text("Create new account",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold))),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
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
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
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
                          icon: Icon(Icons.lock),
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
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.2)),
                  child: TextFormField(
                      controller: confirmPassword,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Password is required!";
                        } else if (password.text != confirmPassword.text) {
                          return "Passwords don't match";
                        }
                        return null;
                      },
                      obscureText: isVisible,
                      decoration: InputDecoration(
                          icon: Icon(Icons.lock),
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
                
                // Expanded(child: 
                  Container(
                  margin: const EdgeInsets.all(10),
                  // padding: const EdgeInsets.symmetric(
                  //     horizontal: 15.0, vertical: 10),
                  height: 25,
                  // width: 100,
                  child:
                      Expanded(child: 
                        ListTile(
                          title: const Text('Do you want to be an Admin?'),
                          // leading: Switch(
                          //   value: isAdmin, 
                          //   onChanged:(value) {
                          //     setState(() {
                          //       isAdmin = !isAdmin;
                          //     });
                          //    },
                              leading: Switch(
                                value: isAdmin,
                                onChanged: (value) {
                                  setState(() {
                                    isAdmin = !isAdmin;
                                  });
                                },
                                    
                                
                                activeTrackColor: Colors.lightGreenAccent,
                                activeColor: Colors.green,
                                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, // Reduces the tap target size
                                // Wrap the Switch in a Transform.scale to adjust the size
                                
                              )
                            // activeTrackColor: Colors.white,
                            // activeColor: Colors.purple,

                            ),
                        )
                      
                  
                    
                  
                ),
               
                
                Container(
                  height: 30
                  ),


                Container(
                  height: 55,
                  width: MediaQuery.of(context).size.width * .9,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {}
                      },
                      child: Text("SIGNUP",
                          style: TextStyle(color: Colors.white))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Allready have an account?"),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const LoginScreen()));
                      },
                      child: const Text('LOGIN'),
                    )
                  ],
                )
              
          
]            ),
          ),
        ),
      ),
        ),
    );
  }
}
