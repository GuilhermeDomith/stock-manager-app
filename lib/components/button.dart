import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppCleanButton extends StatelessWidget{

  AppCleanButton({
    @required this.label,
    this.onClick,
    this.color,
    this.borderColor,
  });

  final String label;
  final Function onClick;
  final Color color;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    var primaryColorDark = Theme.of(context).primaryColorLight;

    return OutlineButton(
      textColor: this.color ?? primaryColorDark,
      child: Text(this.label),
      shape: RoundedRectangleBorder(
          side: BorderSide(
              color: this.borderColor ?? primaryColorDark,
              width: 2,
              style: BorderStyle.solid
          ),
          borderRadius: BorderRadius.circular(3)
      ),
      onPressed: this.onClick,
    );
  }
}