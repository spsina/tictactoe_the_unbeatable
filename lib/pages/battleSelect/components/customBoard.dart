import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

class CustomBoard extends StatefulWidget{

  // initializes a new game board
  // always sets the game starter to X

  @override
  _CustomBoardState createState() => _CustomBoardState();
}

class _CustomBoardState extends State<CustomBoard> {

  double boardSize = 4;
  double winBy = 4;
  bool withAi = true;
  String aiPlayer = "O";
  String starter = "X";

  String playingAs(){
    var _playingAs;
    _playingAs = aiPlayer == "X" ? "O" : "X";
    return _playingAs;
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;
    TextStyle _style = TextStyle(color: Colors.white, fontSize: tileSize / 2.5);

    return AlertDialog (
      backgroundColor: Color(0xff222831),
      content: Container (
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("BOARD SIZE: ", style: _style,),
                  Text(boardSize.toInt().toString(), style: _style,)
                ],
              )
            ),
            Slider(
              value: boardSize,
              min: 3,
              max: 10,
              onChanged: (val) {
                setState(() {
                  boardSize = val;
                  if (boardSize < winBy)
                    winBy = boardSize;
                });
              },
            ),
            Container(
              child:Text("WIN BY " + winBy.toInt().toString() +" IN A LINE", style: _style,)
            ),
            Slider(
              value: winBy,
              min: 3,
              max:boardSize,
              onChanged: (val) {
                setState(() {
                  winBy = val;
                });
              },
            ),
            Text("PLAY AGAINST AI", style: _style,),
            Checkbox(
              value: withAi,
              onChanged: (val) {
                setState(() {
                  withAi = val;
                });
              },
            ),
            AnimatedOpacity(
              opacity: withAi? 1.0:0.0,
              duration: Duration(milliseconds: 100),
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text("AI PLAYER", style: _style,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text("X", style: _style,),
                        Switch(
                          value: aiPlayer == "X" ? false : true,
                          onChanged: (val) {
                            setState(() {
                              aiPlayer = aiPlayer == "X" ? "O" : "X";
                            });
                          },
                        ),
                        Text("O", style: _style,),
                      ],
                    )
                  ],
                ),
              ),

            ),
            Container(
              child: Column(
                children: <Widget>[
                  Text("STARTING PLAYER", style: _style,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Text("X", style: _style,),
                      Switch(
                        value: starter == "X" ? false : true,
                        onChanged: (val) {
                          setState(() {
                            starter = starter == "X" ? "O" : "X";
                          });
                        },
                      ),
                      Text("O", style: _style,),
                    ],
                  )
                ],
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry (
                      GameBoard(size: boardSize.toInt(),
                    playingAs: withAi ? playingAs() : "X" , starter: starter,gameMode: withAi ? GameMode.AI : GameMode.LOCAL, winBy: winBy.toInt(),))),
                );
              },
              color: Color(0xffffac41),
              child: Icon(Icons.play_arrow, color: Colors.white,),
            )
          ],
        ),
      ),
    );
  }
}