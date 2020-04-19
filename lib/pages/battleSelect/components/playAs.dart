import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

class PlayAs extends StatelessWidget{
  final int size;

  PlayAs(this.size);

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return AlertDialog (
      title: new Text("PLAY AS", style: TextStyle(color: Colors.white),),
      backgroundColor: Color(0xff222831),
      content: Container (
        height: tileSize * 2,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry (GameBoard(size, x, x))),
                );
              },
              child: Container(
                width: tileSize * 2,
                margin: EdgeInsets.only(top:tileSize / 5),
                child: FlareActor (
                  "assets/animations/battle/your_turn.flr",
                  alignment:Alignment.center, 
                  sizeFromArtboard: true, 
                  animation:"Alarm"
                )
              ),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry (GameBoard(size, o, x))),
                );
              },
              child: Container(
                width: tileSize * 2,
                margin: EdgeInsets.only(top:tileSize / 5),
                child: FlareActor (
                  "assets/animations/battle/thinking.flr",
                  alignment:Alignment.center, 
                  sizeFromArtboard: true, 
                  animation:"Alarm"
                )
              ),
            )
          ],
        ),
      ),
    );
  }
}