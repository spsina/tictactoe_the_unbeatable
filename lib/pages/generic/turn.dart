import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';

class Trun extends StatelessWidget{
  final Player player;

  Trun(this.player);

  @override
  Widget build(BuildContext context) {
    bool isX = player.type == PlayerType.X;

    return Container(
      margin: EdgeInsets.only(top: 53),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(isX ? "YOUR TURN" : "AI'S TURN", style: TextStyle(
                  color: Color(0xffF4F4F4),
                  fontSize: 37
                ),
              ),

              Container(
                margin: EdgeInsets.only(top:70),
                child: Image(
                  image: AssetImage( isX ?
                                    "assets/images/battleSelect/your_turn.png"
                                    :"assets/images/battleSelect/ai_turn.png"
                                    ),
                    width: 146,
                    height: 146,
                  ),
              )
            ],
          )
        ],
      ),
    );
  }

}
