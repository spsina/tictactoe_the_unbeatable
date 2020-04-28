import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

import '../../battle/battle.dart';

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

  int boardSize = 4;
  int winBy = 4;
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
        aiPlayerWidget = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Container(
                child: Text("AI PLAYER", style: _style,),
              ),
              Container(
                child: DropdownButton<String>(
                  underline: SizedBox(),
                  dropdownColor: Color(0xff323232),
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
                        style: TextStyle(fontFamily: "", color: Color(0xaaffbd69)),),
                    );
                  }).toList(),
                ),
              )
            ],
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Game size
          Container(
            child: Text("BOARD SIZE " + boardSize.round().toString(), style: _style,),
          ),
          Container(
            child: Slider(
              value: boardSize.toDouble(),
              min: 4,
              max: 10,
              divisions: 6,
              label: '$boardSize',
              inactiveColor: Colors.black,
              activeColor: Color(0xaaffbd69),
              onChanged: (val) {
                setState(() {
                  boardSize = val.round();
                  if (winBy > boardSize)
                    winBy = boardSize;
                });
              }, 
            ),
          ),
          // win by
          Container(
            child: Text("WIN BY " + winBy.round().toString() + " IN A LINE", style: _style,),
          ),
          Slider(
            value: winBy.toDouble(),
            min: 3,
            max: boardSize.toDouble(),
            divisions: boardSize.round() - 3,
            label: "$winBy",
            inactiveColor: Colors.black,
            activeColor: Color(0xaaffbd69),
            onChanged: (val) {
              setState(() {
                winBy = val.round();
              });
            },
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("GAME MODE", style: _style,),
                ),
                Flexible(
                  child: Container(
                    width: 150,
                    child: DropdownButton<GameMode>(
                      dropdownColor: Color(0xff323232),
                      underline: SizedBox(),
                      isExpanded: true,
                      isDense: false,
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
                          strVal = "2 PLAYERS - OFFLINE";
                        return DropdownMenuItem<GameMode>(
                          value: value,
                          child: SizedBox(
                            width: 200,
                            child: Text(strVal,textAlign: TextAlign.right ,style: TextStyle(fontFamily: "", color: Color(0xaaffbd69)),),
                        ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Text("STARTING PLAYER", style: _style,),
                ),
                Container(
                  child: DropdownButton<String>(
                    underline: SizedBox(),
                    dropdownColor: Color(0xff323232),
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
                        child: Text(value, style: TextStyle(fontFamily: "", color: Color(0xaaffbd69)),),
                      );
                    }).toList(),
                  ),
                )
              ],
            ),
          Container(
            child: AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: aiPlayerWidget,
            ),
          ),
        ],
      ),
    );
  }
}