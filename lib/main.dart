import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:stock_manager_app/pages/login_page.dart';

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
      title: 'Stock Manager',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        primaryColor: Color(0xFFDD2C00),
        primaryColorLight: Color(0xFFff6434),
        primaryColorDark: Color(0xFFA30000),
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      debugShowCheckedModeBanner: false,
      supportedLocales: [const Locale('pt', 'BR')],
      home: LoginPage()
    );
  }
}