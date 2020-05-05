import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tictactoe/utils/style.dart';

/* Animated Show Dialog */
void animatedShowDialog(BuildContext context, String title, String body) {
  showDialog(
    context: context,
    builder: (BuildContext context) => FlareGiffyDialog(
      flarePath: 'assets/animations/Update.flr',
      flareAnimation: 'spin1',
      title: Text(
        title.toUpperCase(),
        style: blackTitleStyle,
      ),
      description: Text(
        body,
        textAlign: TextAlign.center,
        style: blackBodyStyle,
      ),
      entryAnimation: EntryAnimation.DEFAULT,
      onOkButtonPressed: () {
        Navigator.of(context).pop();
      },
      onlyOkButton: true,
      buttonOkColor: Color(0xffffbd69),
      buttonOkText: Text(
        'OKAY',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

void generalShowDialog(
    BuildContext context, String title, String body, Color color) {
  showDialog(
    context: context,
    builder: (BuildContext context) => AlertDialog(
      backgroundColor: color,
      title: Text(
        title.toUpperCase(),
        style: whiteTitleStyle,
      ),
      content: Text(
        body,
        style: whiteBodyStyle,
      ),
    ),
  );
}

void fancyShowDialog(
    BuildContext context, String title, String body, Color color) {
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
        height: 250.0,
        width: 300.0,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: 250,
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
                child: Text(
                  title.toUpperCase(),
                  style: whiteTitleStyle,
                ),
              ),
            ),
            Container(
              width: 300.0,
              height: 150.0,
              alignment: Alignment.center,
              margin: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  body,
                  style: whiteBodyStyle,
                  textAlign: TextAlign.justify,
                ),
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
                        "OKAY",
                        style: TextStyle(
                            color: Color(0xffffbd69),
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
