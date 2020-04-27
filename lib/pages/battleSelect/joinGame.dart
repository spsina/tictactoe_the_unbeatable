import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/gameInfoUi.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'battleSelect.dart';
import 'package:tictactoe/main.dart';

class JoinGame extends StatefulWidget{
  final String initialGameId;

  const JoinGame({Key key, this.initialGameId}) : super(key: key);
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  bool loading = false;                                               // indicates if there is any request being processed
  bool isGameInfoMode = false;                                        // game info UI or enter gameId ui
  String gameId;                                                      // game id
  GameInfoUi gameInfoUi;                                              // Widget that shows retrieved info about a game
  final gameIdController = TextEditingController();
  var buttonChild = Icon(Icons.group_add, color: Colors.white,);      // add, play, loading


  _JoinGameState() {
    wsc.subscribe(socketListener);
  }

  @override
  initState() {
    // this widget might be invoked from a link,
    // so if there is an initial gameId present
    // set it as the text of gameId input
    if (widget.initialGameId != null){
      gameIdController.text = widget.initialGameId;
    }
    super.initState();
  }

  void getGameInfo () async {
    setState(() {
      loading = true;
      gameId = gameIdController.text;
    });
    bool result = await wsc.send({
      'type': "JOIN",
      'rmode': 'partial',
      'gameId': gameIdController.text
      }
    );

    setState(() {
      if (!result)
        loading = false;
    });
  }

  void joinAndPlay() {
    // join and notify the opponent
    wsc.send({
      'type': "JOIN",
      'rmode': 'full',
      'gameId': gameId
    });

    wsc.unsubscribe(socketListener);
    // start the game
    navigate(context, GameBoard(
      size: gameInfoUi.size,
      winBy: gameInfoUi.winBy,
      gameMode: GameMode.ONLINE,
      playingAs: gameInfoUi.playAs,
      gameId: gameId,
      starter: gameInfoUi.playAs == "X"? "O":"X",),
    );
  }

  void socketListener(dictData) {
    setState(() {
      loading = false;
    });

    if (dictData['status'] == 200) {
      var game = dictData['game'];
      setState(() {
        isGameInfoMode = true;
        gameInfoUi = GameInfoUi(size: game['size'], winBy: game['winBy'], playAs: game['starter'] == "X" ? "O" : "X");
        buttonChild = Icon(Icons.play_arrow, color: Colors.white,);
      });
    } else if (dictData['status'] == -1) {
      toastError("Your opponent left the game");

      // set the state to enter game id
      setState(() {
        isGameInfoMode = false;
      });
    } else if (dictData['status'] == 404) {
      toastError("Invalid Game ID");

      // set the state to enter game id
      setState(() {
        isGameInfoMode = false;
      });
    }
  }

  void clearConnection() {
    // unsubscribe
    wsc.unsubscribe(socketListener);

  }

  @override
  void deactivate() {
    clearConnection();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
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
                clearConnection();
                navigate(context, BattleSelectPage());
              }
          ),
        ],
      ),
    );
  }
}