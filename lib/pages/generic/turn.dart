import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:flare_flutter/flare_actor.dart';

class Turn extends StatelessWidget{
  final Player player;
  final int _key;

  Turn(this.player, this._key) : super(key: ValueKey<int>(_key));

  @override
  Widget build(BuildContext context) {
    bool isX = player.type == PlayerType.X;
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.only(top: tileSize / 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Column(
            children: <Widget>[
              Container(
                width: tileSize * 4,
                height: tileSize * 4,
                margin: EdgeInsets.only(top:tileSize / 5),
                child: FlareActor(
                  isX ? "assets/animations/battle/your_turn.flr"
                        :"assets/animations/battle/thinking.flr", 
                  alignment:Alignment.center, 
                  sizeFromArtboard: true, 
                  animation:"Alarm"
                )
              ),
              Text(isX ? ".:: YOUR TURN ::." : ".:: AI IS THINKING ::.", style: TextStyle(
                  color: Color(0xffF4F4F4),
                  fontSize: tileSize / 4
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

}
