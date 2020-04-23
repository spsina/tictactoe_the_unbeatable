import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/dialogs.dart';

import 'battleOption.dart';

class BattleOptionWrapper extends StatelessWidget{

  final String title;
  final Color titleColor;
  final int size;
  final GameMode gameMode;
  final String description;
  final String imgPath;

  BattleOptionWrapper({this.title, this.titleColor, this.description, this.size, this.gameMode, this.imgPath});

  @override
  Widget build(BuildContext context) {
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
        child: BattleOption(imgPath,
            Center(
              child: Column (
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
                  Expanded(
                      child:
                      SingleChildScrollView(
                        child: Text (
                          description,
                          style: TextStyle (
                              color : Color(0xffdbdbdb),
                              fontFamily: "",
                              fontSize: 14
                          ),
                        ),
                      )

                  ),
                ],
              ),
            )
        ),
      ),
    );
  }

}