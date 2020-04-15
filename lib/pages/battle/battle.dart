import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/generic/turn.dart';
import 'package:tuple/tuple.dart';



class GameBoard extends StatefulWidget {
  /*
    The 3x3 game board
  */
  final int size;

  GameBoard(this.size);

  Game createState() => Game();
}


class Game extends State<GameBoard> {
  
  List<List<String>> _board;
  Player turn = Player(PlayerType.X);
  Turn turnWidget = Turn(Player(PlayerType.X), 0);
  Tuple2<int,int> lastMove = Tuple2<int, int> (-1, -1);

  @override
  void initState() {
      _board = List<List<String>>.generate(widget.size, (i) { 
        return List<String>.generate(widget.size, (j) => ""); 
      });
      super.initState();
  }

  void moveTo(Tuple2<int, int> dest){
    setState(() {
      int i = dest.item1; int j = dest.item2;
      if (_board[i][j] == ""){
        _board[i][j] = turn.getRepresentation();
        lastMove = dest;
      }
        turn = count("X") == count("O") ? 
          Player(PlayerType.X): Player(PlayerType.O);
        if (turn.type == PlayerType.X)
          turnWidget = Turn(turn, 0);
        else
          turnWidget = Turn(turn, 1);
    });
  }

  int count(String target){
    int c = 0;
    _board.forEach((row) {
      row.forEach((cell) {
        if (cell == target)
          c++;
      });
    });

    return c;
  }

  @override
  Widget build(BuildContext context) {
    // get the player 
    
    
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      child: Column(
        children: <Widget>[
          AnimatedSwitcher(
            duration: Duration(milliseconds: 500),
            child: turnWidget,
          ),
          Container (
            margin: EdgeInsets.only(top: tileSize/ 2),
            child: Column (
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              // a list of row, each containig a list of cols
              children: List<Widget>.generate(widget.size, (i) {
                // generate a row
                return Container(
                  margin: EdgeInsets.only(top: tileSize/5, right: 10, left:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(widget.size, (j) {
                      // each cell
                      return Material(
                        color: (i == lastMove.item1 && j == lastMove.item2) ? Color(0xffffac41) : Color(0xffd3d6db),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: InkWell(
                          splashColor: Color(0xfff4f4f4),
                          onTap: (){ 
                            setState(() {
                              moveTo(Tuple2<int,int>(i,j));
                            });
                          },
                          child: Container(
                            
                            width: (9 - (widget.size+1)*0.2)/widget.size * tileSize,
                            height: (9 - (widget.size+1)*0.3)/widget.size * tileSize,
                            child: Center(
                              child: Text(_board[i][j], textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: ((9 - (widget.size+1)*0.3)/widget.size * tileSize ) * 0.5,
                                  color: _board[i][j] == "X" ? Color(0xff11999e):Color(0xff3c3c3c)
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
          ),
          Expanded(
            child: Align(
              child: Container(
                height: tileSize,
                color: Color(0xffff1e56),
                child: FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Entry(BattleSelectPage())),
                      );
                    },
                    child: Container(
                      width: tileSize * 3,
                      height: tileSize,
                      child: Center( 
                        child: Text("RESIGN", style: TextStyle(color: Colors.white),),
                      )
                    )
                  ),
              ),
              alignment: Alignment.bottomCenter,

            ),
          )
        ],
      ),
    );
  }

}