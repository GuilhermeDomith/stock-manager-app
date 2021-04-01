
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:stock_manager_app/components/button.dart';
import 'package:stock_manager_app/components/text.dart';
import 'package:stock_manager_app/components/text_field.dart';


class CardInputText extends StatelessWidget{

  CardInputText({
    this.label,
    this.description,
    this.onComplete,
    this.controller,
    Key key
  }) : super(key: key);

  final String label;
  final String description;
  final Function onComplete;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return CardInput(
        label: this.label,
        description: this.description,
        onComplete: this.onComplete,
        component: CustomTextField(
          controller: this.controller,
          color: Colors.blue,
        )
    );
  }
}

class DatePickerController {

  DatePickerController({this.date}) {
    if(this.date == null)
      this.date = DateTime.now();
  }

  DateTime date;

  void dispose(){ }

}


class CardInputDate extends StatelessWidget{

  static final DateFormat dtFormat = new DateFormat('dd/MM/y');


  CardInputDate({
    this.label,
    this.description,
    this.onComplete,
    this.controller,
    Key key
  }) : super(key: key);

  final String label;
  final String description;
  final Function onComplete;
  final DatePickerController controller;

  final TextEditingController _textFieldCtrl = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {

    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: controller.date,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));

    if (picked != null && picked != controller.date) {
      controller.date = picked;
      _textFieldCtrl.text = dtFormat.format(controller.date);
    }
  }

  @override
  Widget build(BuildContext context) {

    _textFieldCtrl.text = dtFormat.format(controller.date);

    return CardInput(
        label: this.label,
        description: this.description,
        onComplete: this.onComplete,
        component: CustomTextField(
          controller: this._textFieldCtrl,
          color: Colors.blue,
          onTap: () => _selectDate(context),
        )
    );
  }
}


class CardInput extends StatelessWidget{
  CardInput({
    this.label,
    this.description,
    this.onComplete,
    this.component,
    Key key
  }) : super(key: key);

  final String label;
  final String description;
  final Function onComplete;
  final Widget component;

  @override
  Widget build(BuildContext context) {

    var height = MediaQuery.of(context).size.height * 0.5;
    var width = MediaQuery.of(context).size.width;

    return  Center(
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Card(
          child: Container(
            padding: EdgeInsets.all(16),
            width: width,
            height: height,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[

                Padding(
                    padding: EdgeInsets.symmetric(vertical: 5),
                  child: this._title()
                ),

                Padding(
                    padding: EdgeInsets.symmetric(vertical: (this.description != null)? 15 : 0),
                    child: this._description()
                ),

                Divider(),

                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: this.component
                  ),
                ),

                ButtonBar(
                  buttonMinWidth: width,
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    AppCleanButton(
                      label: 'Confirmar',
                      color: Colors.blue,
                      onClick: () => this.onComplete(),
                    )
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _title() {
    return Align(
      alignment: Alignment.center,
      child: CustomText(
        label: this.label,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _description() {
    if(this.description != null)
      return Align(
        alignment: Alignment.center,
        child: CustomText(
          label: this.description,
          fontWeight: FontWeight.normal,
          fontSize: 18,
        ),
      );
    else
      return null;
  }

}




