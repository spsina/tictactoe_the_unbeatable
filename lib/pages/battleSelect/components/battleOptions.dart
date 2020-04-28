import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptionWrapper.dart';

class BattleOptions extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;


    return Container(
      margin: EdgeInsets.only(top: tileSize),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000),
            blurRadius: 20.0, // has the effect of softening the shadow
            spreadRadius: 5.0, // has the effect of extending the shadow
            offset: Offset(
              0.0, // horizontal, move right 10
              0.0, // vertical, move down 10
          ),
        )
      ]
      ),
      height: tileSize*6,
      width: 9 * tileSize,
      child:
      Container (
        child: ListView(
          children: <Widget>[
            BattleOptionWrapper(
              aiPlayer: AIPlayer.SELECT,
              starter: "X",
              color: Color(0xffff1e56),
              size: 3,
              winBy: 3,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/3x3_death.png",
              isCustom: false,
            ),
            BattleOptionWrapper(
              aiPlayer: AIPlayer.SELECT,
              starter: "X",
              color: Color(0xffffac41),
              size: 5,
              winBy: 4,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/5x5_challenge.png",
              isCustom: false,

            ),
            BattleOptionWrapper(
              aiPlayer: AIPlayer.SELECT,
              starter: "X",
              color: Color(0xff16817a),
              size: 7,
              winBy: 5,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/7x7.png",
              isCustom: false,

            ),
          ],
        ),
      )
      );
  }

}