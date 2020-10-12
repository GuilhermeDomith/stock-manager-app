import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void okDialog(BuildContext context, title, message, {Function onClose}) async {
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () => Navigator.of(context).pop(),
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton
    ],
  );

  // show the dialog
  await showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  ).then((_) { if (onClose != null) onClose(); });
}

void confirmDialog(
    BuildContext context,
    String title,
    String message,
    {Function onConfirm, Function onCancel}) {

  Widget okButton = FlatButton(
      child: Text("CONFIRMAR"),
      onPressed: () {
        Navigator.of(context).pop();
        if (onConfirm != null) onConfirm();
      });

  Widget cancelButton = FlatButton(
    child: Text("CANCELAR"),
    onPressed: () {
      Navigator.of(context).pop();
      if (onCancel != null) onCancel();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      cancelButton,
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) => alert,
  ).then((_) { if (onCancel != null) onCancel(); });
}

showSnackBar(BuildContext scaffoldContext, String message, int duration){
  Scaffold.of(scaffoldContext)
      .showSnackBar(
    SnackBar(
      content: Text(message),
      duration: Duration(seconds: duration),
    ),
  );
}
