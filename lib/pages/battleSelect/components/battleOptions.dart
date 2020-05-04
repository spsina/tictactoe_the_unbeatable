import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptionWrapper.dart';

class BattleOptions extends StatelessWidget{
  final ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;


    return Container(
      margin: EdgeInsets.only(top: tileSize / 2),
      width: 9 * tileSize,
      child:
      Container (
        child: ListView(
          controller: controller,
          children: <Widget>[
          BattleOptionWrapper(
              imgPath: "assets/images/battleSelect/wheel.png",
              isCustom: true,
              description: "You can create a custom board, with custom settings. Choose to play online with a friend or against AI",
              color: Color(0xffdbdbdb),
            ),
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