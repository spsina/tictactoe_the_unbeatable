import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';

class LoosePage extends StatelessWidget{
  final int boardSize;
  
  LoosePage(this.boardSize);

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      child: Column (
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: tileSize * 3),
                child: Text("YOU LOOSE", 
                  style: TextStyle(
                    color: Color(0xfff4f4f4),
                    fontSize: tileSize / 1.1
                  ),
                ),
              )
            ],
          ),
          Container(
            width: tileSize * 6,
            margin: EdgeInsets.only(top: tileSize),
            child: Image(image: AssetImage('assets/images/win/loose.png'),)
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Entry(BattleSelectPage())),
                      );
                    },
                    child: Container(
                      color: Color(0xff323232),
                      width: tileSize * 3,
                      height: tileSize,
                      child: Center( 
                        child: Text("HOME", style: TextStyle(color: Colors.white, fontSize: tileSize / 3.5),),
                      )
                    )
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Entry(GameBoard(boardSize, x))),
                      );
                    },
                    child: Container(
                      color: Color(0xff323232),
                      width: tileSize * 3,
                      padding: EdgeInsets.all(10),
                      height: tileSize,
                      child: Center( 
                        child: Text("REPLAY", style: TextStyle(
                          color: Colors.white,
                          fontSize: tileSize / 3.5
                          ),),
                      )
                    )
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

}