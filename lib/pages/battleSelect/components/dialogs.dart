import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/playAs.dart';
import 'package:tictactoe/utils/helper.dart';

void showPlayAsOptions(
    BuildContext context, int size, GameMode gameMode, int winBy) {
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
      return AlertDialog(
          title: new Text(
            "Do you want to leave?",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Color(0xff1f4068),
          content: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        goHome(context, false);
                      },
                      icon: Icon(
                        Icons.check_circle,
                        size: 40,
                        color: Color(0xff8EC6C5),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      onPressed: () {
                        navigatorKey.currentState.pop();
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 40,
                        color: Color(0xffff1e56),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ));
    },
  );
}
