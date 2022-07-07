import 'package:flutter/material.dart';

/// Utility class used to create and display dialogs
class ViewUtil {

  /// set up the AlertDialog
  static void showMessage(String title, String message, BuildContext context) {
    final Widget okButton = TextButton(
      child: const Text('OK'),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    final alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    /// show the dialog
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
