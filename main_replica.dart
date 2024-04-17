import "package:flutter/material.dart";
// import "package:flutter_application_1/main.dart";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My app',
      theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow)),
      home: const MyHomePage(title: 'My first mobile app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  // @override
  void _increment() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),

      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'you have pushed the button this many times'
              ),
              Text(
                '$_counter',
                style: Theme.of(context).textTheme.headlineMedium,
              )
            ],
        )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _increment,
        tooltip: 'Increment',
        child: const Icon(Icons.add)
        ),
    );
  }
}