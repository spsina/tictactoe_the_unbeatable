import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:tictactoe/game/board.dart';

enum GameState {
  ONGOING,
  WIN,
  LOSE,
  TIE,
}

class Turn extends StatelessWidget{
  final String player;
  final GameState state; 

  Turn(this.player, this.state) : super(key: ValueKey<int>(state.hashCode.toInt()));

  @override
  Widget build(BuildContext context) {
    bool isX = player == x;
    double tileSize = MediaQuery. of(context).size.width / 9;
    
    var source;
    var text;
    if (state == GameState.ONGOING){
      source = isX ? "assets/animations/battle/your_turn.flr"
                    :"assets/animations/battle/thinking.flr";
      text = isX ? ".:: YOUR TURN ::." : ".:: AI IS THINKING ::.";

    } else if (state == GameState.WIN) {
      source = "assets/animations/battle/win.flr";
      text = "YOU WIN";
    } else if (state == GameState.LOSE){
      source = "assets/animations/battle/lose.flr";
      text = "YOU LOSE";
    } else {
      source = "assets/animations/battle/tie.flr";
      text = "NOT BAD, THAT WAS A TIE";
    }

    return Container(
      margin: EdgeInsets.only(top: tileSize / 5),
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
                  source,
                  alignment:Alignment.center, 
                  sizeFromArtboard: true, 
                  animation:"Alarm"
                )
              ),
              Text(text, style: TextStyle(
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
