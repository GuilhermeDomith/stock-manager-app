import 'package:flutter/material.dart';

class AppCard extends StatelessWidget {

  AppCard({
    @required this.child,
    this.width,
    this.height}) : super();

  Widget child;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height * 0.5;
    var width = MediaQuery.of(context).size.width;

    return Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            width: this.width ?? width,
            height: this.height ?? height,
            child: this.child
        ),
      ),
    );
  }
}