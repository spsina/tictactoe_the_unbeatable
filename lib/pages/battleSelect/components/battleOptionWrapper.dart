import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/dialogs.dart';
import 'package:tictactoe/pages/battleSelect/customBoardPage.dart';
import 'package:tictactoe/pages/generic/helper.dart';

import 'battleOption.dart';

enum AIPlayer {X, O, SELECT, NONE}

class BattleOptionWrapper extends StatelessWidget{

  final Color color;                 // this color is used for the title
  final int size;                    // size of the board
  final AIPlayer aiPlayer;           // the player that ai plays as, if set to select, an option will be shown to choose before the game starts
  final String starter;              // player that starts the game
  final GameMode gameMode;           // Local, with ai, or online
  final String imgPath;              // an image to be shown for the level
  final int winBy;                   // number of symbols in a line to win
  final bool isCustom;               // is it an option created by the user

  const BattleOptionWrapper({Key key, this.color, this.size, this.aiPlayer,
    this.starter, this.gameMode, this.imgPath, this.winBy, this.isCustom}) : super(key: key);

  String get aiPlayerStr {
    if (aiPlayer == AIPlayer.X)
      return "X";
    else if (aiPlayer == AIPlayer.O)
      return "O";
    else if (aiPlayer == AIPlayer.SELECT)
      return "YOU CHOOSE";
    else
      return "NO AI";
  }

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle (color : color,);

    final _styleInfo = TextStyle (color : Colors.white, fontSize: 14, fontFamily: "");
    double tileSize = MediaQuery. of(context).size.width / 9;

    String titleText = isCustom ? "n x n" : (size.toString() + "x" + size.toString());

    var bodyUi;

    if (isCustom) {
      bodyUi = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("AI PLAYER: YOUR CHOICE", style: _styleInfo ),
          Text("STARTING PLAYER: YOUR CHOICE", style: _styleInfo,),
          Text("WIN BY: YOUR CHOICE", style: _styleInfo ),
          Container(
            margin: EdgeInsets.only(top:1),
            child:Text("AI LEVEL: YOUR CHOICE " , style:TextStyle (color : Colors.white, fontSize: 14, fontFamily: "")),
          ),
        ],
      );
    } else {
      bodyUi = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("AI PLAYER: " + aiPlayerStr, style: _styleInfo ),
          Text("STARTING PLAYER: " + starter, style: _styleInfo,),
          Text("WIN BY: " + winBy.toString() + " IN A LINE", style: _styleInfo ),
          Container(
            margin: EdgeInsets.only(top:1),
            child:Text("AI LEVEL: UNBEATABLE " , style:TextStyle (color : Color(0xaa900c3f), fontSize: 14, fontFamily: "")),
          ),
        ],
      );
    }


    return Container(
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: color,
        onTap: () {
          if (isCustom)
            navigate(context, CustomBoardPage(), false);
          else
            showPlayAsOptions(context, size, gameMode, winBy);
        },
        child: BattleOption(
          imgPath,
          Column (
            children: <Widget>[
              Container(
                width: 2 * tileSize,
                height: 1.5 * tileSize,
                child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text(titleText,
                    textAlign: TextAlign.left,
                    style: TextStyle (
                      color : color,
                    ),
                  ),
                ),
              ),
              FittedBox(
                fit: BoxFit.contain,
                child: bodyUi
              )
            ],
          ),
        ),
      ),
    );
  }

}