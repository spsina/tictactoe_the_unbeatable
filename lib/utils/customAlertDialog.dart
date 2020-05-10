import 'package:flutter/material.dart';
import 'package:giffy_dialog/giffy_dialog.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/gameInfoUi.dart';
import 'package:tictactoe/utils/helper.dart';
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
        style: blackTitleStyle(context),
      ),
      description: Text(
        body,
        textAlign: TextAlign.center,
        style: blackBodyStyle(context),
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
        style: whiteTitleStyle(context),
      ),
      content: Text(
        body,
        style: whiteBodyStyle(context),
      ),
    ),
  );
}

void fancyShowDialog(
    BuildContext context, String title, String body, Color color) {
      double tileSize = MediaQuery.of(context).size.width / 9;
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
        height: tileSize*5,
        width: tileSize*3,
        child: Stack(
          children: <Widget>[
            Container(
              width: double.infinity,
              height: tileSize*5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            Container(
              width: double.infinity,
              height: tileSize*0.8,
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
                  style: whiteTitleStyle(context),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              height: tileSize*3,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(tileSize*0.28, tileSize*0.31, tileSize*0.28, tileSize*0.31),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  body,
                  style: whiteBodyStyle(context),
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
                  height: tileSize*0.8,
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
                            fontSize: tileSize*0.3,
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

Future<void> randomGameDialog(
    BuildContext context, GameBoard gameBoard, bool isPlay) {
  double tileSize = MediaQuery.of(context).size.width / 9;
  return showDialog(
    context: context,
    builder: (context) => Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        width: tileSize*3,
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff1f4068),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: double.infinity,
                height: tileSize*0.8,
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
                    isPlay ? "Let's play a random game!" : "game info",
                    style: whiteTitleStyle(context),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                alignment: Alignment.center,
                margin: EdgeInsets.all(20),
                child: Align(
                  alignment: Alignment.center,
                  child: GameInfoUi(size: gameBoard.size,
                      winBy: gameBoard.winBy,
                      playAs: gameBoard.playingAs,
                      level: gameBoard.level
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
                    height: tileSize*0.8,
                    child: Align(
                      alignment: Alignment.center,
                      child: FlatButton(
                        onPressed: () {
                          if (isPlay)
                            navigate(gameBoard, false);
                          else
                            navigatorKey.currentState.pop();
                        },
                        child: Text(
                          isPlay? "PLAY" : "OWKAY",
                          style: TextStyle(
                              color: Color(0xffffbd69),
                              fontSize: tileSize*0.3,
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
    ),
  );
}