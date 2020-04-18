import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/generic/turn.dart';
import 'package:tuple/tuple.dart';


class GameBoard extends StatefulWidget {
  /*
    The size by size game board
  */
  final int size;                   // size of the game board
  final String playingAs;           // playing as
  final String starter;             // player who starts the game

  GameBoard(this.size, this.playingAs, this.starter);

  Game createState() => Game();
}


class Game extends State<GameBoard> {
  
  Board board;
  Widget turnWidget;

  void initialize(){
    board = Board(widget.size, widget.starter);
    // makeAIMove();
    turnWidget = Turn(board.player, GameState.ONGOING);
  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  
  // Future<void> makeAIMove() async {
  //   Tuple2 aiMove = await compute<List< List < String > >, Tuple2  >(alphaBeta, board.board);
  //   moveTo(aiMove.item2);
  // }

  void playerMoveTo(i, j) async{
      moveTo(Tuple2(i,j));

    // if (widget.playingAs == board.player && board.board[i][j] == "" && ! board.terminal().item1){
    //   moveTo(Tuple2(i,j));
      
    //   // await makeAIMove();
    // }
  }

  void moveTo(Tuple2 m) {
    if (m == null)
      return;
    
    int i = m.item1; int j = m.item2;
    setState(() {
      board.moveTo(i, j);
      turnWidget = Turn(board.player, GameState.ONGOING);
    });

  }

  @override
  Widget build(BuildContext context) {
    // get the player 

    final double tileSize = MediaQuery. of(context).size.width / 9;
    
    var done = board.terminal();

    if (done.item1){
      if (done.item2 == null) {
        setState(() {
          turnWidget = Turn(board.player,  GameState.TIE);
        });
      }else if (done.item2 == widget.playingAs){
        setState(() {
          turnWidget = Turn(board.player, GameState.WIN);
        });
      } else {
        turnWidget = Turn(board.player,  GameState.LOSE);
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