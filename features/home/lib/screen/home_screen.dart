import 'package:flutter/material.dart';
import 'package:foundation/infra/router/core_navigator.dart';
import 'package:foundation/interfaces/builders/screens/search.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _MyHomeTestePageState();
}

class _MyHomeTestePageState extends State<HomeScreen> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("widget.title")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'teste',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          CoreNavigator.of(context).pushNamed(SearchRoute());
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
