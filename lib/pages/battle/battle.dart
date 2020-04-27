import 'dart:convert';
import 'dart:io';

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
import 'package:web_socket_channel/io.dart';

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
  final Color xBackgroundColor = Color(0xaa005082);
  final Color xNewBackgroundColor = Color(0xff005082);

  final Color oBackgroundColor =  Color(0xaaffbd69);
  final Color oNewBackgroundColor = Color(0xffffbd69);

  final Color defaultBackgroundColor = Color(0xfff4f4f4);

  WebSocket socket;
  IOWebSocketChannel channel;
  Board board;
  Widget turnWidget;


  bool ready = false;


  void socketListener(dynamic message) {
    var dictData = jsonDecode(message.toString());

    if (dictData['status'] == 300) {
      var move = dictData['move'];
      moveTo(Tuple2(move['x'], move['y']));
    } else if (dictData['status'] == 600) {
      setState(() {
        initialize();
      });
    }
  }

  Future<IOWebSocketChannel> createConnection(url) async {
    socket = await WebSocket
        .connect(url)
        .timeout(Duration(seconds: 15));
    channel = IOWebSocketChannel(socket);
    channel.stream.listen(this.socketListener);
    return channel;
  }

  void initialize() async{

    ready = false;

    board = Board(widget.size, widget.starter, widget.winBy);
    
    turnWidget = Turn(this);


    if (widget.gameMode == GameMode.ONLINE && socket == null) {
      // if game mode is online. establish a connection to server
      try {
        await createConnection('ws://cafepay.app:9090');
        channel.sink.add(jsonEncode({
          'type': 'JOIN',
          'rmode': 'full',
          'gameId': widget.gameId
        }));
      } catch (err) {
        toastError("Try again later");
        navigate(context, BattleSelectPage());
      }
    }

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

    setState(() {
      ready = true;
    });

  }

  @override
  void initState() {
    initialize();
    super.initState();
  }

  @override
  void deactivate() {
    if (socket != null)
      socket.close();
    super.deactivate();
  }
  
  Future<void> makeAIMove() async {
    Tuple2 aiMove = await compute(alphabeta, board);
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

      // hand the board to the opponent
      if (widget.gameMode == GameMode.AI)
        await makeAIMove();
      else if (widget.gameMode == GameMode.ONLINE) {
        // board cast the move first
        channel.sink.add(jsonEncode({
          'type': 'PUT',
          'rmode': 'move',
          'gameId': widget.gameId,
          'move': {
            'x': i,
            'y': j
          }
        }));

        // wait for the opponent move now
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
                if (socket != null)
                  socket.close();
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Entry(BattleSelectPage())),
                );
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
                  channel.sink.add(jsonEncode({
                    'type': 'PUT',
                    'rmode': 'reset',
                    'gameId': widget.gameId
                  }));
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