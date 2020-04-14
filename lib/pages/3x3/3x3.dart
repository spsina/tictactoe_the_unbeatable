import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/pages/generic/turn.dart';



class GameBoard extends StatefulWidget {
  /*
    The 3x3 game board
  */
  final Player player;
  final int size;

  GameBoard(this.player, this.size);

  ThreeByThreeState createState() => ThreeByThreeState();
}


class ThreeByThreeState extends State<GameBoard> {
  
  List<List<String>> _board;
  
  @override
  void initState() {
      _board = List<List<String>>.generate(widget.size, (i) { 
        return List<String>.generate(widget.size, (j) => ""); 
      });
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // get the player 
    Player player = widget.player;
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      child: Column(
        children: <Widget>[
          Trun(player),
          Container (
            margin: EdgeInsets.only(top: tileSize/ 2),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // a list of row, each containig a list of cols
              children: List<Widget>.generate(widget.size, (i) {
                // generate a row
                return Container(
                  margin: EdgeInsets.only(top: tileSize/5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(widget.size, (j) {
                      // each cell
                      return Material(
                        color: Color(0xff323232),
                        child: InkWell(
                          splashColor: Color(0xff222831),
                          onTap: (){ 
                            setState(() {
                              _board[i][j] = player.getRepresentation();
                            });
                          },
                          child: Container(
                            width: (9 - (widget.size+1)*0.3)/widget.size * tileSize,
                            height: (9 - (widget.size+1)*0.5)/widget.size * tileSize,
                            child: Center(
                              child: Text(_board[i][j], textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: ((9 - (widget.size+1)*0.3)/widget.size * tileSize ) * 0.5,
                                  color: Color(0xffdbdbdb)
                                ),
                              ),
                            )
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
            )
          )
        ],
      ),
    );
  }

}