import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/game/ai.dart';
import 'package:tictactoe/game/board.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:tictactoe/pages/generic/turn.dart';
import 'package:tuple/tuple.dart';
import 'package:vibration/vibration.dart';
import 'package:wakelock/wakelock.dart';

enum GameMode {
  AI,
  LOCAL,
  ONLINE
}

class GameBoard extends StatefulWidget {
  final String gameId;              // used for online game
  final int size;                   // size of the game board
  final String playingAs;           // playing as
  final String starter;             // player who starts the game
  final GameMode gameMode;          // AI, LOCAL, ONLINE
  final int winBy;

  GameBoard({this.size, this.playingAs, this.starter, this.gameMode, this.winBy, this.gameId});
  Game createState() => Game();
}


class Game extends State<GameBoard> {

  // color fields used to paint the game board
  final Color xBackgroundColor = Color(0x88005082);                   // X background color
  final Color xNewBackgroundColor = Color(0xff005082);                // X last move background color

  final Color oBackgroundColor =  Color(0xaaffbd69);                  // O background color
  final Color oNewBackgroundColor = Color(0xffffbd69);                // O last move background color

  final Color defaultBackgroundColor = Color(0xfff4f4f4);             // default background color

  Board board;                                                        // actual game board
  Widget turnWidget;                                                  // this widget receives a game state and shows proper animation and message
  bool ready = false;                                                 // in case of online games, indicates if game is ready to begin


  @override
  void initState() {
    initialize();
    super.initState();
  }


  void initialize() async{
    // prevent the screen from turning off
    Wakelock.enable();

    ready = false;
    board = Board(widget.size, widget.starter, widget.winBy);
    turnWidget = Turn(this);

    if (widget.gameMode == GameMode.ONLINE) {
      // if game mode is online. establish a connection to server
      await wsc.subscribe(socketListener);
    }

    // if the starter of the game is not the same as the player
    if (widget.starter != widget.playingAs) {

      // if playing against AI, wait for AI move
      if (widget.gameMode == GameMode.AI)
        makeAIMove();
      else if (widget.gameMode == GameMode.ONLINE) {
        // todo: wait for opponent move
      } else if (widget.gameMode == GameMode.LOCAL) {
        // on a local game, players decide who starts first
      }

    }

    setState(() {
      ready = true;
    });

  }


  void socketListener(dictData) {
    // listener function for online games

    if (dictData['status'] == 300) {
      // a new move haas been made
      var move = dictData['move'];
      moveTo(Tuple2(move['x'], move['y']));

    } else if (dictData['status'] == 600) {
      // a game reset has been submitted by the opponent
      setState(() {
        initialize();
      });
    } else if (dictData['status'] == 204) {
      toastError("Your opponent left the game");

      clearConnection();
      goHome(context);
    } else if (dictData['status'] == -1 ) {
      // connection dropped
      clearConnection();
      goHome(context);
    }
  }

  void clearGame() {
    // send a delete request for game with id gameId
    if (widget.gameId != null) {
      wsc.send({
        'type': "DELETE",
        'gameId': widget.gameId
      });
    }
  }

  void clearConnection() {
    // clear game and unsubscribe
    clearGame();
    wsc.unsubscribe(socketListener);

    // don't prevent the screen from turning off
    Wakelock.disable();

  }

  void moveVibrate() async{
    // each time a move is made
    // this vibration will happen
    if (await Vibration.hasVibrator()) {
      Vibration.cancel();
      Vibration.vibrate(duration: 20);
    }
  }
  
  Future<void> makeAIMove() async {
    // pass the board to AI and wait for ai move
    Tuple2 aiMove = await compute(alphaBeta, board);
    moveTo(aiMove);
  }

  void playerMoveTo(i, j) async {

    // ignore the call if the game is finished
    if (board.terminal().item1)
      return ;

    // if the cell is not empty ignore
    if (board.board[i][j] != "")
      return;

    // there are no constraints on a local game
    if (widget.gameMode == GameMode.LOCAL){
      moveTo(Tuple2(i, j));
    } else {

      // if it's not your turn, ignore the move
      if (board.player != widget.playingAs )
        return;

      // make the move
      moveTo(Tuple2(i,j));

      // hand the board to the opponent
      if (widget.gameMode == GameMode.AI)
        await makeAIMove();
      else if (widget.gameMode == GameMode.ONLINE) {
        // board cast the move first
        wsc.send({
          'type': 'PUT',
          'rmode': 'move',
          'gameId': widget.gameId,
          'move': {
            'x': i,
            'y': j
          }
        });
        // wait for the opponent move now
      }

    }
  }

  void moveTo(Tuple2 m) {
    // not sure why it happens, but sometimes this function is called with a null move
    // rejecting the null move does not seem to break the game
    if (m == null)
      return;

    moveVibrate();

    int i = m.item1; int j = m.item2;
    setState(() {

      // make the move on the board
      board.moveTo(i, j);

      // update the turn widget
      turnWidget = Turn(this);
    });

  }

  @override
  void dispose() {
    clearConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    // using timeSize ensures consistent results in different screen sizes
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

    return Scaffold(
      backgroundColor: Color(0xff1B2429),

      body: Container(
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
                  // a list of row, each containing a list of cols
                  children: List<Widget>.generate(board.size, (i) {
                    // generate a row
                    return Container(
                      margin: EdgeInsets.only(top: tileSize/5, right: 10, left:10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List<Widget>.generate(board.size, (j) {
                          // each cell
                          return Material(
                            color: (i == board.lastMove.item1 && j == board.lastMove.item2) ?
                            board.board[i][j] == 'X' ? xNewBackgroundColor : oNewBackgroundColor:
                            board.board[i][j] == 'X' ? xBackgroundColor : board.board[i][j] == 'O' ? oBackgroundColor :
                                defaultBackgroundColor
                            ,
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
                                        color: Colors.white
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
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.home),
              backgroundColor: Colors.red,
              label: 'HOME',
              labelStyle: TextStyle(fontSize: 14.0),
              onTap: () {
                clearConnection();
                goHome(context);
              }
          ),
          SpeedDialChild(
            child: Icon(Icons.replay),
            backgroundColor: Colors.blue,
            label: 'RESTART THE GAME',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: () {
              setState(() {
                if (widget.gameMode == GameMode.ONLINE) {
                  // notify other player to reset the game as well
                  wsc.send(
                      {
                        'type': 'PUT',
                        'rmode': 'reset',
                        'gameId': widget.gameId
                      }
                  );
                }
                initialize();
              });
            }
          ),
        ],
      ),
    );
  }

}