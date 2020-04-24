import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

class CustomBoard extends StatefulWidget{

  // initializes a new game board
  // always sets the game starter to X

  _CustomBoardState currentState;

  @override
  _CustomBoardState createState() {
    currentState = _CustomBoardState();
    return currentState;
  }
}

class _CustomBoardState extends State<CustomBoard> {

  double boardSize = 4;
  double winBy = 4;
  bool withAi = true;
  String aiPlayer = "O";
  String starter = "X";
  GameMode gameMode = GameMode.AI;

  var aiPlayerWidget;

  String playingAs(){
    var _playingAs;
    _playingAs = aiPlayer == "X" ? "O" : "X";
    return _playingAs;
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;
    TextStyle _style = TextStyle(color: Colors.white, fontSize: tileSize / 2.8);
    setState(() {
      if (gameMode == GameMode.AI) {
        aiPlayerWidget = FittedBox(
          fit: BoxFit.contain,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                child: Text("AI PLAYER", style: _style,),
              ),
              Container(
                margin: EdgeInsets.only(left: 20),
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  dropdownColor: Colors.black,
                  value: aiPlayer,
                  elevation: 20,
                  onChanged: (String value) {
                    setState(() {
                      aiPlayer = value;
                    });
                  },
                  items: <String>["X", "O"].map<DropdownMenuItem<String>>((
                      String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                        style: TextStyle(fontFamily: "", color: Colors.white),),
                    );
                  }).toList(),
                ),
              )
            ],
          ),
        );
      } else if (gameMode == GameMode.ONLINE) {
        aiPlayerWidget = Center(
            child:Text("YOU WILL BE THE STARTING PLAYER", style: TextStyle(color: Colors.grey, fontFamily: ""),)
        );
      } else {
        aiPlayerWidget = SizedBox();
      }
    });

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          // Game size
          Container(
            child: Text("BOARD SIZE " + boardSize.toInt().toString(), style: _style,),
          ),
          Container(
            child: Slider(
              value: boardSize,
              min: 3,
              max: 10,
              onChanged: (val) {
                setState(() {
                  boardSize = val;
                  if (winBy > boardSize)
                    winBy = boardSize;
                });
              },
            ),
          ),
          // win by
          Container(
            child: Text("WIN BY " + winBy.toInt().toString() + " IN A LINE", style: _style,),
          ),
          Slider(
            value: winBy,
            min: 3,
            max: boardSize,
            onChanged: (val) {
              setState(() {
                winBy = val;
              });
            },
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("GAME MODE", style: _style,),
                ),
                Container(
                  margin: EdgeInsets.only(left:20),
                  child: DropdownButton<GameMode>(
                    underline: SizedBox(),
                    dropdownColor: Colors.black,
                    value: gameMode,
                    elevation: 20,
                    onChanged: (GameMode value) {
                      setState(() {
                        gameMode=value;
                      });
                      },
                    items: <GameMode>[GameMode.AI, GameMode.ONLINE, GameMode.LOCAL]
                        .map<DropdownMenuItem<GameMode>>((GameMode value) {
                      var strVal;
                      if (value == GameMode.AI)
                        strVal = "1 PLAYER";
                      else if (value == GameMode.ONLINE)
                        strVal = "2 PLAYERS - ONLINE";
                      else
                        strVal = "2 PLAYERS - OFFLINE ";
                      return DropdownMenuItem<GameMode>(
                        value: value,
                        child: Text(strVal, style: TextStyle(fontFamily: "", color: Colors.white),),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          FittedBox(
            fit: BoxFit.contain,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  child: Text("STARTING PLAYER", style: _style,),
                ),
                Container(
                  margin: EdgeInsets.only(left:20),
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    dropdownColor: Colors.black,
                    value: starter,
                    elevation: 20,
                    onChanged: (String value) {
                      setState(() {
                        starter=value;
                      });
                      },
                    items: <String>["X", "O"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value, style: TextStyle(fontFamily: "", color: Colors.white),),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          ),
          Container(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: aiPlayerWidget
            ),
          ),
        ],
      ),
    );
  }
}