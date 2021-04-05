import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{

  CustomTextField({this.controller, this.color, this.onTap});

  final TextEditingController controller;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    var defaultColor = Theme.of(context).primaryColorLight;

    return TextField(
      controller: this.controller,
      onTap: this.onTap,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color ?? defaultColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color ?? defaultColor),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color ?? defaultColor),
        ),
      ),
      style: TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontSize: 25,
      ),
    );
  }

}