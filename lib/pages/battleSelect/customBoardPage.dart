import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/waitingForOpponentUi.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'battleSelect.dart';
import 'components/customBoard.dart';

class CustomBoardPage extends StatefulWidget{
  @override
  _CustomBoardPageState createState() => _CustomBoardPageState();
}

enum GeneralState {
  CREATE, // Creating new game
  WAITING // waiting for opponent to join the game
}

class _CustomBoardPageState extends State<CustomBoardPage> {
  // UI for generating a custom board, generated data can also be accessed from this object
  final _customBoard = CustomBoard();

  Widget buttonChild;                                 // child widget of the inkwell widget, it's either play icon or loading icon
  bool loading = false;                               // indicates if some request is being sent or received
  String gameId;                                      // an online generated gameId
  GeneralState generalState = GeneralState.CREATE;    // overall state of the widget
  bool isReady = false;                               // subscription status

  _CustomBoardPageState() {
    // subscribe to the global wsc
    _subscribe();
  }

  Future<void> _subscribe() async {
    await wsc.subscribe(socketListener);
    setState(() {
      isReady = true;
    });
  }

  void socketListener(dynamic dictData) {
    // a dictionary message is expected

    setState(() {
      loading = false;

      if (dictData['status'] == 201) {
        // game creation has been successful
        gameId = dictData['gameId'];

        // set the general state to waiting,
        // this indicates that the user is
        // waiting for an opponent to join the game
        generalState = GeneralState.WAITING;


      } else if (dictData['status'] == 301) {
        // this means, an opponent has joined the game

        // prepare the game board
        var game = GameBoard(
          size: _customBoard.currentState.boardSize.toInt(),
          winBy: _customBoard.currentState.winBy.toInt(),
          starter: _customBoard.currentState.starter,
          playingAs: _customBoard.currentState.starter,
          level: _customBoard.currentState.level,
          gameMode: GameMode.ONLINE,
          gameId: gameId,
        );

        wsc.unsubscribe(socketListener);

        // lunch the game board
        navigate( game, false);
      } else if (dictData['status'] == -1) {
        setState(() {
          generalState = GeneralState.CREATE;
        });
      } else {
        toastError("Could not create an online game");
      }
    });
  }

  void requestGameId(request) async{
    // sends the request for a new online game
    // and sets the loading to true

    if (!isReady){
      toastInfo("Your connection is not ready yet, try in a second!");
      return;
    }

    setState(() {
      loading = true;
    });

    bool result = await wsc.send(request);

    setState(() {
      if (!result)
        loading = false;
    });
  }

  void clearGame() {
    // send a delete request for game with id gameId
    if (gameId != null) {
      wsc.send({
        'type': "DELETE",
        'gameId': gameId
      });
    }
  }

  void clearConnection() {
    // clear game and unsubscribe
    clearGame();
    wsc.unsubscribe(socketListener);
  }

  @override
  void dispose() {
    clearConnection();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    if (!loading){
      buttonChild = Icon(Icons.play_arrow, color: Colors.white,);
    } else {
      buttonChild = CircularProgressIndicator(backgroundColor: Colors.white);
    }

    // Two different general states might happen
    // 1 - User wants to create a custom level
    // 2 - User is waiting for an online opponent to join the game
    var createUi = Container (
      child: Column (
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff000000),
                    blurRadius: 20.0, // has the effect of softening the shadow
                    spreadRadius: 5.0, // has the effect of extending the shadow
                  )
                ]
            ),
            margin: EdgeInsets.only(top:30),
            padding: EdgeInsets.all(20),
            child: _customBoard
          ),
          InkWell(
            onTap: () {
              if (loading)
                return;
              if (_customBoard.currentState.gameMode != GameMode.ONLINE) {
                GameBoard game = GameBoard(
                  size: _customBoard.currentState.boardSize.toInt(),
                  playingAs: _customBoard.currentState.playingAs(),
                  starter: _customBoard.currentState.starter,
                  gameMode: _customBoard.currentState.gameMode,
                  winBy: _customBoard.currentState.winBy.toInt(),
                  level: _customBoard.currentState.level,
                );
                navigate( game, false);
              } else {
                // create an online game
                var request = {
                  "type": "POST",
                  "size": _customBoard.currentState.boardSize.toInt(),
                  "winBy": _customBoard.currentState.winBy.toInt(),
                  "starter": _customBoard.currentState.starter
                };
                requestGameId(request);
              }
            },
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(10),
              color: Color(0xffffac41),
              child: Center(
                child: buttonChild,
              ),
            ),
          )
        ],
      ),
    );

    return Scaffold(
      backgroundColor: Color(0xff1B2429),
      body: Container(
        margin: EdgeInsets.only(top: tileSize * 1.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 8 * tileSize,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text( "PLAY A CUSTOM BOARD",
                      style: TextStyle(
                        color: Color(0xffF4F4F4),
                      ),
                    )
                ),
              ),
            ),
            AnimatedSwitcher(
              duration: Duration(milliseconds: 100),
              child: (generalState == GeneralState.CREATE) ? createUi : WaitingForOpponentUi(gameId: gameId),
            )
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
        ],
      ),
    );
  }
}