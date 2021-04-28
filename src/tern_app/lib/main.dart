import 'package:flutter/material.dart';
import 'package:tern_app/screens/home_screen.dart';
import 'package:provider/provider.dart';

import 'data/moor_db.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => TernDb(),
      child: MaterialApp(
        title: 'TiiraaTiiraa',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: HomeScreen(initIndex: 0),
      ),
    );
  }
}
