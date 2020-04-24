import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/dialogs.dart';

import 'battleOption.dart';

class BattleOptionWrapper extends StatelessWidget{

  final String title;
  final Color titleColor;
  final int size;
  final String aiPlayer;
  final String starter;
  final GameMode gameMode;
  final String description;
  final String imgPath;
  final int winBy;
  
  BattleOptionWrapper({this.title, this.titleColor, this.description,
   this.size, this.gameMode, this.imgPath, this.aiPlayer, this.starter, this.winBy});

  @override
  Widget build(BuildContext context) {
    final _style = TextStyle (color : titleColor,);

    final _styleInfo = TextStyle (color : Colors.white, fontSize: 10);
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      child: InkWell(
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        highlightColor: Colors.transparent,
        splashColor: titleColor,
        onTap: () {
          showPlayAsOptions(context, size, gameMode);
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
                  child: Text(title,
                    textAlign: TextAlign.left,
                    style: TextStyle (
                      color : titleColor,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("AI PLAYER: " + aiPlayer, style: _styleInfo ),
                  Text("STARTING PLAYER: " + starter, style: _styleInfo,),
                  Text("WIN BY " + winBy.toString() + " IN A LINE", style: _styleInfo ),
                  Container (
                    margin: EdgeInsets.only(top:20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Container(
                          child: GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.share, color: Colors.white),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.edit, color: Colors.white),
                          ),
                        ),
                        Container(
                          child: GestureDetector(
                            onTap: (){},
                            child: Icon(Icons.delete, color: Colors.red),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}