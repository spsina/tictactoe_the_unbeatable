import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/ai.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/generic/turn.dart';
import 'package:tictactoe/pages/win/loose.dart';
import 'package:tictactoe/pages/win/win.dart';
import 'package:tuple/tuple.dart';


class GameBoard extends StatefulWidget {
  /*
    The size by size game board
  */
  final int size;
  final PlayerType playingAs;

  GameBoard(this.size, this.playingAs);

  Game createState() => Game();
}


class Game extends State<GameBoard> {
  
  Board board;
  Widget turnWidget;

  void initialize(){
    board = Board(widget.size);
    turnWidget = Turn(board.player, board.player.key, GameState.ONGOING);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  
  void playerMoveTo(i, j) async{
    if (widget.playingAs == board.player.type && board.board[i][j] == "" && ! terminal(board.board).item1){
      moveTo(Tuple2(i,j));
      Tuple2 aiMove = await compute<List< List < String > >, Tuple2 >(alphaBeta, board.board);

      moveTo(aiMove.item2);
    }
  }

  void moveTo(Tuple2 m) {
    if (m == null)
      return;
    
    int i = m.item1; int j = m.item2;
    setState(() {
      board.moveTo(i, j);
      turnWidget = Turn(board.player, board.player.key, GameState.ONGOING);
    });

  }

  @override
  Widget build(BuildContext context) {
    // get the player 

    final double tileSize = MediaQuery. of(context).size.width / 9;
    
    var done = terminal(board.board);

    if (done.item1){
      if (done.item2 == null) {
        setState(() {
          turnWidget = Turn(board.player, board.player.key, GameState.TIE);
        });
      }else if (done.item2.type == widget.playingAs){
        setState(() {
          turnWidget = Turn(board.player, board.player.key, GameState.WIN);
        });
      } else {
        turnWidget = Turn(board.player, board.player.key, GameState.LOSE);
      }
    }

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
              children: List<Widget>.generate(board.size, (i) {
                // generate a row
                return Container(
                  margin: EdgeInsets.only(top: tileSize/5, right: 10, left:10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List<Widget>.generate(board.size, (j) {
                      // each cell
                      return Material(
                        color: (i == board.lastMove.item1 && j == board.lastMove.item2) ? Color(0xffffac41) : Color(0xffd3d6db),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: InkWell(
                          splashColor: Color(0xfff4f4f4),
                          onTap: (){ 
                            playerMoveTo(i, j);
                          },
                          child: Container(
                            
                            width: (9 - (board.size+1)*0.2)/widget.size * tileSize,
                            height: (9 - (widget.size+1)*0.3)/widget.size * tileSize,
                            child: Center(
                              child: Text(board.board[i][j], textAlign: TextAlign.center, style: TextStyle(
                                  fontSize: ((9 - (widget.size+1)*0.3)/widget.size * tileSize ) * 0.5,
                                  color: board.board[i][j] == "X" ? Color(0xff11999e):Color(0xff3c3c3c)
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
                        width: tileSize * 3,
                        height: tileSize,
                        child: Center(
                          child: Icon(Icons.home, size: 50, color: Color(0xff29a19c),)
                        ) 
                      )
                    ),
                    FlatButton(
                      onPressed: () {
                        setState(() {
                          initialize();
                        });
                      },
                      child: Container(
                        width: tileSize * 3,
                        height: tileSize,
                        child: Center(
                          child: Icon(Icons.replay, size: 50, color: Color(0xff29a19c),)
                        ) 
                      )
                    ),
                  ],
                )
              ),
              alignment: Alignment.bottomCenter,

            ),
          )
        ],
      ),
    );
  }

}