import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/3x3.dart';
import 'package:tictactoe/pages/battleSelect/components/5x5.dart';

class BattleOptions extends StatelessWidget{
  /*
    battle option
    a 3x3 and a 5x5  
  */
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.only(top: tileSize),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Color(0xaaff1e56),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Entry(GameBoard(3, x))),
              );
            },
            child: ThreeByThree(),
          ),
          InkWell(
            focusColor: Colors.transparent,
            hoverColor: Colors.transparent,
            highlightColor: Colors.transparent,
            splashColor: Color(0xaaffac41),
            child: FiveByFive(),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Entry(GameBoard(5, x))),
              );
            },
          )
        ],
      ),
    );
  }

}