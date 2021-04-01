import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCleanButton extends StatelessWidget{

  AppCleanButton({@required this.label, this.onClick, this.color});

  final String label;
  final Function onClick;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return OutlineButton(
      textColor: this.color,
      child: Text(this.label),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: Colors.blue,
              width: 1,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(3)
      ),
      onPressed: this.onClick,
    );
  }
}