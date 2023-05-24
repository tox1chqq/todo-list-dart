import 'package:flutter/material.dart';
import 'package:todolist/screens/home.dart';

void main() => runApp(App());


class App extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home()
    );
  }
}

