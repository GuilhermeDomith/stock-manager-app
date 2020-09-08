import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'add_product_page.dart';
import 'home_page.dart';

class DashboardPage extends StatelessWidget{

  DashboardPage(this.choice, {Key key}) : super(key: key);

  final Choice choice;
  final title = 'Informações';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(this.title),),
      body: Builder(
        builder: (context) =>
          _body(context)
      )
    );
  }

  static Widget newInstance(Choice choice) => DashboardPage(choice);

  Widget _body(BuildContext scaffoldContext) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Column(
        children: <Widget>[
          Container(
            width: MediaQuery.of(scaffoldContext).size.width,
            child: Padding(
              padding: EdgeInsets.all(8),
              child: RaisedButton(
                child: Text('Novo Item'),
                onPressed: () => {
                  Navigator.push(
                      scaffoldContext,
                      MaterialPageRoute(builder: (context) => AddProductPage(scaffoldContext)))
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

}