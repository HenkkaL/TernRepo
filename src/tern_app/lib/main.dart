import 'package:flutter/material.dart';
import 'screens/Home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tiiraa Tiiraa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new Home(),
    );
  }
}