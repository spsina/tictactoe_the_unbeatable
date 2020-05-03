import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class WaitingForOpponentUi extends StatelessWidget{

  final String gameId;

  const WaitingForOpponentUi({Key key, this.gameId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.only(top:30),
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Color(0xff000000),
              blurRadius: 20.0, // has the effect of softening the shadow
              spreadRadius: 5.0, // has the effect of extending the shadow
            )
          ]
      ),
      child: Column(
        children: <Widget>[
          Center (
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                      width: 6 * tileSize,
                      height: tileSize,
                      child: FittedBox(
                          child: SelectableText(
                            gameId,
                            style: TextStyle(color: Colors.white, fontSize: tileSize),
                          )
                      )
                  ),
                  Container(
                    width: 1 * tileSize,
                    child: IconButton(
                      onPressed: (){
                        Share.share("""Let's play tic tac toe.\nGame Id: """ + gameId + "\nhttps://play.l37.ir/game/tictactoe?gameId=" + gameId);
                      },
                      icon: Icon(Icons.share, color: Colors.white,),
                    ),
                  )
                ],
              )
          ),
          Center(
              child: Container(
                  margin: EdgeInsets.all(20),
                  width: 5 * tileSize,
                  child: Image( image: AssetImage("assets/images/battleSelect/waiting.png"), )
              )
          ),
          Center (
            child: Container(
                width: 7 * tileSize,
                child: FittedBox(
                  child:Text("WAITING FOR YOUR OPPONENT TO JOIN", style: TextStyle(color: Colors.white),),
                )
            ),
          ),
          Center (
            child: Container(
                margin: EdgeInsets.all(20),
                width: 6 * tileSize,
                height: tileSize,
                child: SingleChildScrollView(
                    child:Text("""AN OPPONENT CAN JOIN THE GAME USING THE ABOVE GAME ID AT THE 'PLAY WITH A FRIEND' SECTION UNDER THE MAIN MENU AT THE HOME PAGE""",
                      style: TextStyle(color: Colors.white, fontSize: 10, fontFamily: ""),
                      textAlign: TextAlign.center,
                    )
                )
            ),
          ),
        ],
      ),
    );
  }

}