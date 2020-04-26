import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/waitingForOpponentUi.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:web_socket_channel/io.dart';

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
  IOWebSocketChannel channel;
  WebSocket socket;
  Widget buttonChild;
  bool loading = false;
  String gameId = "NA";

  GeneralState generalState = GeneralState.CREATE;

  final _customBoard = CustomBoard();

  void socketListener(dynamic message) {
    var dictData = jsonDecode(message.toString());
    setState(() {
      loading = false;

      if (dictData['status'] == 201) {
        gameId = dictData['gameId'];
        generalState = GeneralState.WAITING;
      } else if (dictData['status'] == 301) {
        // opponent joined start the game
        print("Opponent joined");
      }
        else {
        toastError("An error has occured while requesting an online game");
      }
    });
    // game id generated successfully

    print("[Server] " + dictData.toString());
  }

  Future<IOWebSocketChannel> createConnection(url) async {
    socket = await WebSocket
        .connect(url)
        .timeout(Duration(seconds: 15));
    channel = IOWebSocketChannel(socket);
    channel.stream.listen(this.socketListener);
    return channel;
  }

  void requestGameId(request) async{
    setState(() {
      loading = true;
    });
    try {
      var jsonData = jsonEncode(request);
      await createConnection("ws://192.168.1.50:9090");
      channel.sink.add(jsonData);
    } catch (err) {
      setState(() {
        loading = false;
        toastError("Could not connect to the server");
      });
    }
  }

  @override
  void deactivate() {
    socket.close();
    super.deactivate();
  }

  void toastError(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
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
                );
                navigate(context, game);
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
                if (socket != null)
                socket.close();
                navigate(context, BattleSelectPage());
              }
          ),
        ],
      ),
    );
  }
}