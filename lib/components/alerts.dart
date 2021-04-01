import 'package:flutter/material.dart';


class AppAlerts {

  AppAlerts._();

  /// Show a dialog with one button to close the alert.
  static void showOkDialog(
      BuildContext context,
      {
        String title,
        String message,
        Widget textOkBtn,
        Function onClose,
      }) async {

    var okButton = FlatButton(
      child: textOkBtn ?? Text("OK"),
      onPressed: () => Navigator.of(context).pop(),
    );

    var alert = AppAlertDialog(
      title: title,
      content: message,
      actions: <Widget>[
        okButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext _) => alert,
    ).then((_) { onClose != null ?? onClose(); });
  }

  ///Show dialog with confirm and cancel buttons.
  static void showConfirmDialog(
      BuildContext context,
      {
        String title,
        String message,
        Widget textConfirmBtn,
        Widget textCancelBtn,
        Function onConfirm,
        Function onCancel,
      }) async {

    var okButton = FlatButton(
        child: textConfirmBtn ?? Text("CONFIRMAR"),
        onPressed: () {
          Navigator.of(context).pop();
          onConfirm != null ?? onConfirm();
        });

    var cancelButton = FlatButton(
      child: textCancelBtn ?? Text("CANCELAR"),
      onPressed: () {
        Navigator.of(context).pop();
        onCancel != null ?? onCancel();
      },
    );

    var alert = AppAlertDialog(
      title: title,
      content: message,
      actions: <Widget>[
        cancelButton,
        okButton,
      ],
    );

    await showDialog(
      context: context,
      builder: (BuildContext _) => alert,
    ).then((_) { onCancel != null ?? onCancel(); });
  }

  ///Show snack bar with duration as long specified.
  static void showSnackBar(
      BuildContext scaffoldContext,
      { String message, int duration }) {

    Scaffold.of(scaffoldContext)
        .showSnackBar(
          SnackBar(
              content: Text(message),
              duration: Duration(seconds: duration),
          ),
        );
  }
}

/// Custom AlterDialog with application styles
class AppAlertDialog extends StatelessWidget {

  AppAlertDialog({
    this.title,
    this.content,
    this.actions
  }) : super();

  final String title;
  final String content;
  final List<Widget> actions;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(this.title),
      content: Text(this.content),
      actions: this.actions,
    );
  }

}
