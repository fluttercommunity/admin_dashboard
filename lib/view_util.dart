import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class ViewUtil {
  static void showMessage(String title, String message, BuildContext context){
    // set up the AlertDialog
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}