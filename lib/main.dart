import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stock_manager_app/config.dart';

import 'pages/home_page.dart';

Future<void> main() async {
  await DotEnv().load('.env');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Color(0xFFDD2C00),
        primaryColorLight: Color(0xFFff6434),
        primaryColorDark: Color(0xFFA30000),
      ),
      home: HomePage(),
    );
  }
}