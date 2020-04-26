import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/gameInfoUi.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:web_socket_channel/io.dart';

import 'battleSelect.dart';

class JoinGame extends StatefulWidget{
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  bool loading = false;
  bool isGameInfoMode = false;

  WebSocket socket;
  IOWebSocketChannel channel;
  String gameId;
  GameInfoUi gameInfoUi;

  final gameIdController = TextEditingController();

  var buttonChild = Icon(Icons.group_add, color: Colors.white,);

  void getGameInfo () async {
    setState(() {
      loading = true;
      gameId = gameIdController.text;
    });
    try {
      await createConnection("ws://192.168.1.50:9090");
      channel.sink.add(jsonEncode({
        'type': "JOIN",
        'rmode': 'partial',
        'gameId': gameIdController.text
      }));
    } catch(err) {
      toastError("Could not connect to the server");
      setState(() {
        loading = true;
      });
    }
  }

  void joinAndPlay() {
    // join and notify the opponent
    channel.sink.add(jsonEncode({
      'type': "JOIN",
      'rmode': 'full',
      'gameId': gameId
    }));

    // start the game
    navigate(context, GameBoard(
      size: gameInfoUi.size,
      winBy: gameInfoUi.winBy,
      gameMode: GameMode.ONLINE,
      playingAs: gameInfoUi.playAs,
      starter: gameInfoUi.playAs == "X"? "O":"X",)
    );
  }

  void socketListener(dynamic message) {
    var dictData = jsonDecode(message.toString());
    setState(() {
      loading = false;
    });
    // game id generated successfully
    if (dictData['status'] == 200) {
      var game = dictData['game'];
      setState(() {
        isGameInfoMode = true;
        gameInfoUi = GameInfoUi(size: game['size'], winBy: game['winBy'], playAs: game['starter'] == "X" ? "O" : "X");
        buttonChild = Icon(Icons.play_arrow, color: Colors.white,);
      });
    } else if (dictData['status'] == 301) {
      // ignore
    }
    else {
      toastError("Invalid Game ID");
    }
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

  @override
  Widget build(BuildContext context) {
    gameIdController.text = "wswZqbg5i";
    double tileSize = MediaQuery. of(context).size.width / 9;

    var enterGameIdUi = Column(
      children: <Widget>[
        Row(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Container(
              width: 8 * tileSize,
              child: TextField(
                controller: gameIdController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    hintStyle: TextStyle(color: Colors.grey),
                    border: InputBorder.none,
                    hintText: 'ENTER A GAME ID'
                ),
              ),
            ),
          ],
        )
      ],
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
                    child: Text( "JOIN AN ONLINE GAME",
                      style: TextStyle(
                        color: Color(0xffF4F4F4),
                      ),
                    )
                ),
              ),
            ),
            Container (
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
                      child: AnimatedSwitcher(
                        duration: Duration(milliseconds: 200),
                        child: isGameInfoMode ? gameInfoUi : enterGameIdUi,
                      )
                  ),
                  InkWell(
                    onTap: () {
                      if (loading)
                        return;
                      if (isGameInfoMode)
                        joinAndPlay();
                      else
                        getGameInfo();
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
                navigate(context, BattleSelectPage());
              }
          ),
        ],
      ),
    );
  }
}