import 'package:flutter/material.dart';

import 'first_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        //primarySwatch: Colors.lightGreen,
        primaryColorLight: Colors.purple[800],
        primaryColorDark: Colors.red[800],
        primaryColor: Colors.lightGreen[800],
        //visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: FirstPage(),
    );
  }
}