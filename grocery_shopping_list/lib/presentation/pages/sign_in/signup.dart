import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../services/signup_service.dart';

class Signup extends ConsumerStatefulWidget {
  Signup({Key? key}) : super(key: key);
  // Signup({super.key});
  // final instance = Signup();

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends ConsumerState<Signup> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  var isVisible = true;
  var isAdmin = false;

  @override
  Widget build(BuildContext context) {
    // final authState = watch(authProvider);
    final ApiService _apiService = ApiService();
    // isAdmin = ref.watch(_apiService);
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset("/assets/pic.svg"),
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
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: "Username",
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your username';
                        } else if (value.length < 5) {
                          return 'Username must be at least 5 characters long';
                        }
                        return null;
                      }),
                      
                  
                ),
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 10.0, vertical: 10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.deepPurple.withOpacity(0.2)),
                  child: TextFormField(
                      controller: _passwordController,
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
                                  : Icons.visibility_off))),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters long';
                        }
                        return null;
                      }),
            ),
                            
                
                // Container(
                //   margin: const EdgeInsets.all(10),
                //   padding: const EdgeInsets.symmetric(
                //       horizontal: 10.0, vertical: 10),
                //   decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(8),
                //       color: Colors.deepPurple.withOpacity(0.2)),
                //   child: TextFormField(
                //       obscureText: isVisible,
                //       decoration: InputDecoration(
                //           icon: Icon(Icons.lock),
                //           border: InputBorder.none,
                //           hintText: "Password",
                //           suffixIcon: IconButton(
                //               onPressed: () {
                //                 setState(() {
                //                   isVisible = !isVisible;
                //                 });
                //               },
                //               icon: Icon(isVisible
                //                   ? Icons.visibility
                //                   : Icons.visibility_off)))),
                // ),
                // Container(
                //     margin: const EdgeInsets.all(10),
                //     // padding: const EdgeInsets.symmetric(
                //     //     horizontal: 15.0, vertical: 10),
                //     height: 25,
                //     // width: 100,
                //     child: Row(
                //       children: [
                //         Expanded(
                //           child: ListTile(
                //               title: const Text('Do you want to be an Admin?'),
                //               leading: Switch(
                //                 value: isAdmin,
                //                 onChanged: (value) {
                //                   // AdminState.toggle
                //                   setState(() {
                //                     isAdmin = !isAdmin;
                //                   });
                //                 },
                //                 activeTrackColor: Colors.lightGreenAccent,
                //                 activeColor: Colors.green,
                //                 materialTapTargetSize:
                //                     MaterialTapTargetSize.shrinkWrap,
                //               )),
                //         ),
                //       ],
                //     )),
                Container(height: 30),
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
                      //   // Navigator.pushNamed(context, '/login');
                      //   final username = _usernameController.text;
                      //   final password = _passwordController.text;
                      //   const role = 'user';
                      //   final response = _apiService.signUp(
                      //       username, password, role, context);

                        
                      //     context.go('/login');
                        
                      //   // context.go('/login');
                      // },

                      if (formKey.currentState?.validate() ?? false) {
                          // Form is valid, proceed with signup
                          final username = _usernameController.text;
                          final password = _passwordController.text;
                          const role = 'user';
                          try {
                            final response = _apiService.signUp(
                                username, password, role, context);
                            context.go('/login');
                          } catch (e) {
                            // Handle signup error
                            print('Sign-up failed: $e');
                          }
                        }
                      },
                      child: const Text("SIGNUP",
                          style: TextStyle(color: Colors.white))),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?"),
                    TextButton(
                      onPressed: () {
                        context.go('/login');
                      },
                      child: const Text('LOGIN'),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
