import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:marquee/marquee.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/3x3.dart';
import 'package:tictactoe/pages/battleSelect/components/5x5.dart';
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
              10.0, // horizontal, move right 10
              10.0, // vertical, move down 10
          ),
        )
      ]
      ),
      height: tileSize*6,
      width: 9 * tileSize,
      child: 
      Scrollbar(
        child: ListView(
          children: <Widget>[
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Color(0xaaff1e56),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry(GameBoard(3, x, x))),
                );
              },
              child: BattleOption("assets/images/battleSelect/3x3_death.png",
                Center(
                  child: Column (
                    children: <Widget>[
                      Container(
                        width: 2 * tileSize,
                        height: 1.5 * tileSize,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("3x3", 
                            textAlign: TextAlign.left,
                            style: TextStyle ( 
                              color : Color(0xffff1e56),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: 
                        SingleChildScrollView(
                          child: Text (
                            threeByThreeText, 
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
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Color(0xaaff1e56),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry(GameBoard(5, x,x))),
                );
              },
              child: BattleOption("assets/images/battleSelect/5x5_challenge.png",
                Center(
                  child: Column (
                    children: <Widget>[
                      Container(
                        width: 2 * tileSize,
                        height: 1.5 * tileSize,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("5x5", 
                            textAlign: TextAlign.left,
                            style: TextStyle ( 
                              color : Color(0xffffac41),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: 
                        SingleChildScrollView(
                          child: Text (
                            fiveByfive, 
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
            InkWell(
              focusColor: Colors.transparent,
              hoverColor: Colors.transparent,
              highlightColor: Colors.transparent,
              splashColor: Color(0xaaff1e56),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry(GameBoard(7, x, x))),
                );
              },
              child: BattleOption("assets/images/battleSelect/7x7.png",
                Center(
                  child: Column (
                    children: <Widget>[
                      Container(
                        width: 2 * tileSize,
                        height: 1.5 * tileSize,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text("7x7", 
                            textAlign: TextAlign.left,
                            style: TextStyle ( 
                              color : Color(0xffffac41),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: 
                        SingleChildScrollView(
                          child: Text (
                            fiveByfive, 
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
          
          ],
        ),
      )
      );
  }

}