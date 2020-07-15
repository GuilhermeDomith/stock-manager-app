import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager_app/first_page.dart';

class StockPage extends StatelessWidget{

  const StockPage(this.choice, {Key key}) : super(key:key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {

    final TextStyle textStyle = Theme.of(context).textTheme.headline4;

    return Scaffold(
      appBar: AppBar(title: Text('Products Stock'),),
      body: Card(
            color: Theme.of(context).primaryColor,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(choice.icon, size: 128.0, color: Theme.of(context).primaryColorDark,),
                  Text(choice.title, style: textStyle,)
                ],
              ),
            ),
      ),
    );
  }

  static Widget newInstance(Choice choice) => StockPage(choice);
}