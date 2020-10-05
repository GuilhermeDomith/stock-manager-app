

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget{

  static Color defaultColor = Colors.grey[700];

  CustomText({
    this.label,
    this.color,
    this.fontWeight: FontWeight.bold,
    this.fontSize: 25
  });

  final String label;
  final Color color;
  final FontWeight fontWeight;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    var color = (this.color == null)? defaultColor : this.color;

    return Text(
        this.label,
        textAlign: TextAlign.left,
        style: TextStyle(
          color: color,
          fontWeight: this.fontWeight,
          fontSize: this.fontSize,
        ),
      );
  }

}
