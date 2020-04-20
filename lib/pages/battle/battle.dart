import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../game/ai.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/generic/turn.dart';
import 'package:tuple/tuple.dart';

enum GameMode {
  AI,
  LOCAL,
  ONLINE
}

class GameBoard extends StatefulWidget {

  final int size;                   // size of the game board
  final String playingAs;           // playing as
  final String starter;             // player who starts the game
  final GameMode gameMode;          // AI, LOCAL, ONLINE

  GameBoard(this.size, this.playingAs, this.starter, this.gameMode);
  Game createState() => Game();
}


class Game extends State<GameBoard> {
  
  Board board;
  Widget turnWidget;

  void initialize(){
    board = Board(widget.size, widget.starter);
    
    turnWidget = Turn(this);

    // if the starter of the game is not the same as the player
    if (widget.starter != widget.playingAs) {

      // if playing agaist AI, wait for AI move
      if (widget.gameMode == GameMode.AI)
        makeAIMove();
      else if (widget.gameMode == GameMode.ONLINE) {
        // todo: wait for opponent move
      } else if (widget.gameMode == GameMode.LOCAL) {
        // on a local game, players decide who starts first
      }

    }

  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  
  Future<void> makeAIMove() async {
    Tuple2 aiMove = await compute(AI.alphabeta, board);
    moveTo(aiMove);
  }

  void playerMoveTo(i, j) async {

    // ignore the call if the game is finished
    if (board.terminal().item1)
      return ;

    // there are no constraints on a local game
    if (widget.gameMode == GameMode.LOCAL){
      moveTo(Tuple2(i, j));
    } else {
      // if it's not your turn,
      // or the cell is not empty, reject the move
      
      if (board.player != widget.playingAs || board.board[i][j] != "")
        return;
      
      // make the move
      moveTo(Tuple2(i,j));

      // hand the board to the opponent if game did not terminat after your move
      if (board.terminal().item1)
        return;
      
      if (widget.gameMode == GameMode.AI)
        await makeAIMove();
      else if (widget.gameMode == GameMode.ONLINE) {
        // todo: wait for opponent move
      }

    }
  }

  void moveTo(Tuple2 m) {

    // not sure why it happens, but sometimes this function is called with a null move
    // rejecting the null move does not seem to break the game
    if (m == null)
      return;
    
    int i = m.item1; int j = m.item2;
    setState(() {

      // make the move on the board
      board.moveTo(i, j);

      // update the turn widget
      turnWidget = Turn(this);
    });

  }

  @override
  Widget build(BuildContext context) {
    final double tileSize = MediaQuery. of(context).size.width / 9;
    
    // check if the game is finished
    var done = board.terminal();
    if (done.item1){
      // if the game is finished

      setState(() {
        // update the turn widget
        turnWidget = Turn(this);
      });
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