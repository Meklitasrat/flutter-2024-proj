import "package:flutter/material.dart";
// import "package:english_words/english_words.dart";
// import './random_words.dart';
// import './grocery.dart';

import './Authentication/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // final wordPair = WordPair.random();
    return MaterialApp(

        // title: 'word pair generator',
        theme: ThemeData.from(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amberAccent)),
        home: LoginScreen());
  }
}
