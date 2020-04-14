import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';

class Trun extends StatelessWidget{
  final Player player;

  Trun(this.player);

  @override
  Widget build(BuildContext context) {
    bool isX = player.type == PlayerType.X;
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.only(top: tileSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(isX ? "YOUR TURN" : "AI'S TURN", style: TextStyle(
                  color: Color(0xffF4F4F4),
                  fontSize: tileSize
                ),
              ),

              Container(
                margin: EdgeInsets.only(top:tileSize / 5),
                child: Image(
                  image: AssetImage( isX ?
                                    "assets/images/battleSelect/your_turn.png"
                                    :"assets/images/battleSelect/ai_turn.png"
                                    ),
                    width: tileSize * 3,
                    height: tileSize * 3,
                  ),
              )
            ],
          )
        ],
      ),
    );
  }

}
