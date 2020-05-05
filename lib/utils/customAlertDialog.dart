import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tictactoe/game/ai.dart';

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

void fancyShowDialog(
    BuildContext context, Widget title, Widget body, Color color) {
  showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        height: 300.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: 50,
              alignment: Alignment.bottomCenter,
              decoration: BoxDecoration(
                color: Color(0xffffbd69),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
              ),
              child: Align(
                alignment: Alignment.center,
                child: title,
              ),
            ),
            Container(
              width: double.infinity,
              height: 200,
              alignment: Alignment.center,
              child: Align(
                alignment: Alignment.center,
                child: body,
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: double.infinity,
                  height: 50,
                  child: Align(
                    alignment: Alignment.center,
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        "Okay",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
