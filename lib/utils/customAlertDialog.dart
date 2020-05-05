import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';

void animatedShowDialog(BuildContext context, Widget title, Widget body) {
  showDialog(
    context: context,
    builder: (BuildContext context) => FlareGiffyDialog(
      flarePath: 'assets/animations/Update.flr',
      flareAnimation: 'spin1',
      title: title,
      description: body,
      entryAnimation: EntryAnimation.DEFAULT,
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
      onlyOkButton: true,
      buttonOkColor: Color(0xffffbd69),
      buttonOkText: Text(
        'OK',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    ),
  );
}

void generalShowDialog(
    BuildContext context, Widget title, Widget body, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: color,
      title: title,
      content: body,
    ),
  );
}