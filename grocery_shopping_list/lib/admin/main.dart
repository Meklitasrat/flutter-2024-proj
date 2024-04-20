import 'package:flutter/material.dart';
import '../admin/models/user.dart';
import '../admin/user_dialog.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyFlutterList(),
      title: 'My Flutter List',
    );
  }
}

class MyFlutterList extends StatefulWidget {
  const MyFlutterList({Key? key}) : super(key: key);

  @override
  _MyFlutterListState createState() => _MyFlutterListState();
}

class _MyFlutterListState extends State<MyFlutterList> {
  List<User> userList = [];

  @override
  Widget build(BuildContext context) {
    void addUserData(User user) {
      setState(() {
        userList.add(user);
      });
    }

    void editUserData(int index, User user) {
      setState(() {
        userList[index] = user;
      });
    }

    void showUserDialog({User? user, int? index}) {
      showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: AddUserDialog(addUser: addUserData, editUser: editUserData, user: user, index: index),
          );
        },
      );
    }

    void editUser(int index) {
      User user = userList[index];
      showUserDialog(user: user, index: index);
    }

    void deleteUser(int index) {
      setState(() {
        userList.removeAt(index);
      });
    }

    return Scaffold(
      floatingActionButton: null, // Remove the FloatingActionButton
      bottomNavigationBar: BottomAppBar(
        child: Center(
          child: TextButton(
            onPressed: () => showUserDialog(),
            child: Text(
              'Add a shop',
              style: TextStyle(color: Colors.white), // Text color
            ),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color.fromARGB(255, 110, 112, 240)), // Button color
            ),
          ),
        ),
      ),
      appBar: AppBar(
        title: Text('Shemeta Shoppings'),
        backgroundColor: Color.fromARGB(255, 124, 118, 207),
      ),
      body: Center( // Wrap the Container with Center widget
        child: Container(
          height: 400,
          width: 600,
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return Card(
                margin: EdgeInsets.all(4),
                elevation: 8,
                child: Padding(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        textAlign: TextAlign.center,
                        userList[index].username,
                        style: TextStyle(
                          fontSize: 22,
                          color: Color.fromARGB(255, 85, 52, 231),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        textAlign: TextAlign.center,
                        'Location: ${userList[index].location}',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Items:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: userList[index].items.map((item) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8.0),
                            child: Text(
                              '- $item',
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                            onPressed: () => editUser(index),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Color.fromARGB(255, 23, 20, 184).withOpacity(0.5); // Set hover background color
                                  }
                                  return Color.fromARGB(255, 23, 20, 184); // Default background color
                                },
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                            ),
                            child: Text('Edit'),
                          ),
                          SizedBox(width: 16),
                          TextButton(
                            onPressed: () => deleteUser(index),
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                (Set<MaterialState> states) {
                                  if (states.contains(MaterialState.hovered)) {
                                    return Colors.red.withOpacity(0.5); // Set hover background color
                                  }
                                  return Colors.red; // Default background color
                                },
                              ),
                              foregroundColor: MaterialStateProperty.all<Color>(Colors.white), // Text color
                            ),
                            child: Text('Delete'),
                          ),
                        ],
                      ),

                    ],
                  ),
                ),
              );
            },
            itemCount: userList.length,
          ),
        ),
      ),
    );
  }
}