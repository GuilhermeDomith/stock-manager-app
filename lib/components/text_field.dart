import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget{

  CustomTextField({this.controller, this.color, this.onTap});

  final TextEditingController controller;
  final Color color;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      onTap: this.onTap,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color),
        ),
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: this.color),
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