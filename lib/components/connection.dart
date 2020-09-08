import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LostConnection extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(16),
            child: Icon(Icons.signal_wifi_off),
          ),
          Text('Conexão perdida.'),
        ],
      ),
    );
  }


}