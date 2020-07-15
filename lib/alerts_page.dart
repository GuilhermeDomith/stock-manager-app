import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stock_manager_app/first_page.dart';

class StockAlertsPage extends StatelessWidget{

  const StockAlertsPage(this.choice, {Key key}) : super(key:key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    List<String> names = const ['a', 'b'];
    return Scaffold(
      appBar: AppBar(title: Text("Stock Alerts"),),
      body: ListView.builder(
          itemCount: names.length,
          itemBuilder: (BuildContext context, int index) =>
            Padding(
              padding: EdgeInsets.all(16),
              child: Card(
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: (){
                    Scaffold.of(context).showSnackBar(
                        SnackBar(
                            duration: Duration(seconds: 5),
                            content: Text('Card Tapped')
                        ));
                  },
                  child: Container(
                    height: 100,
                    child: Text(names[index]),
                  ),
                ),
              ),
            ),
        ),
      );
  }

  static Widget newInstance(Choice choice) => StockAlertsPage(choice);
}