import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameInfoUi extends StatelessWidget{
  final int size;
  final int winBy;
  final String playAs;
  final int level;

  const GameInfoUi({Key key, this.size, this.winBy, this.playAs, this.level}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return
      Container(
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[],
            ),
            Container (
              width: 3 * tileSize,
              child: FittedBox(
                child: Text("GAME INFO", style: TextStyle(color: Colors.white), textAlign: TextAlign.center,),
              ),
            ),
            Container(
              width: 5 *tileSize,
              margin: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text("SIZE ", style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        child: Text(size.toString(), style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                  Divider(color: Colors.white,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text("WIN BY ", style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        child: Text(winBy.toString(), style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text("PLAY AS ", style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        child: Text(playAs.toLowerCase(), style: TextStyle(color: Colors.white),),
                      )
                    ],
                  ),
                  Divider(color: Colors.white,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        child: Text("AI LEVEL ", style: TextStyle(color: Colors.white),),
                      ),
                      Container(
                        child: Text( (level != null) ? level.toString() : "FRIENDLY!", style: TextStyle(color: Colors.white),),
                      )
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      );
  }

}