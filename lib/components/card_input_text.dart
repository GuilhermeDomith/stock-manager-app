
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CardInputText extends StatelessWidget{
  CardInputText({
    this.label,
    this.onComplete,
    this.controller,
    Key key
  }) : super(key: key);

  final String label;
  final Function onComplete;
  final TextEditingController controller;

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

                Container(
                  height: height * 0.2,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      this.label,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.grey[700],
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                      ),
                    ),
                  ),
                ),

                Divider(),

                Expanded(
                  child: Align(
                      alignment: Alignment.center,
                      child: TextField(
                        controller: this.controller,
                        decoration: InputDecoration(
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.blue),
                          ),
                        ),
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 25,
                        ),
                      )
                  ),
                ),

                ButtonBar(
                  buttonMinWidth: width,
                  alignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlineButton(
                      textColor: Colors.blue,
                      child: Text('Confirmar' ),
                      shape: RoundedRectangleBorder(
                          side: BorderSide(
                              color: Colors.blue,
                              width: 1,
                              style: BorderStyle.solid
                          ),
                          borderRadius: BorderRadius.circular(3)
                      ),
                      onPressed: () => this.onComplete(),
                    ),
                  ],
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

}