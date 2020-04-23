import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOption.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptionWrapper.dart';
import 'package:tictactoe/pages/battleSelect/components/playAs.dart';
import 'package:tictactoe/pages/battleSelect/components/strings.dart';


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
              title: '3x3',
              titleColor: Color(0xffff1e56),
              description: threeByThreeText,
              size: 3,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/3x3_death.png",
            ),
            BattleOptionWrapper(
              title: '5x5',
              titleColor: Color(0xffffac41),
              description: fiveByfive,
              size: 5,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/5x5_challenge.png",
            ),
            BattleOptionWrapper(
              title: '7x7',
              titleColor: Color(0xff16817a),
              description: "",
              size: 7,
              gameMode: GameMode.AI,
              imgPath: "assets/images/battleSelect/7x7.png",
            ),
          ],
        ),
      )
      );
  }

}