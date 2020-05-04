
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/playAs.dart';
import 'file:///C:/Users/sina/Desktop/dev/tictactoe/lib/utils/helper.dart';

import 'customBoard.dart';

void showPlayAsOptions(BuildContext context, int size, GameMode gameMode, int winBy) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PlayAs(size, gameMode, winBy);
    },
  );
}

void askToGoHome(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog (
        title: new Text("Do you want to leave?", style: TextStyle(color: Colors.white, fontSize: 15),),
        backgroundColor: Color(0xffff1e56),
        content: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: () { goHome(context, false); },
                    icon: Icon(Icons.check, size: 40, color: Color(0xffffac41),),
                  ),
                ],
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () { navigatorKey.currentState.pop(); },
                    icon: Icon(Icons.cancel, size: 40, color: Color(0xff1f4068),),
                  ),
                ],
              ),
            ],
          ),
        )
      );
    },
  );
}