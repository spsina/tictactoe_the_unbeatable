import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/game/board.dart';

class Turn extends StatelessWidget{

  final Game game;

  Turn(this.game) : super(key: ValueKey<int>(game.hashCode.toInt()));

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;
    
    var source;
    var text;

    var finished = game.board.terminal();

    if (!finished.item1) {

      /*
         if the game is not finished. show who we are waiting on
      */

      // choose the animation

      if (game.board.player == x)
        // this indicates, waiting on X to make a move
        source = "assets/animations/battle/your_turn.flr";
      else
        // this means, waiting on O to make a move
        source = "assets/animations/battle/thinking.flr";

      // choose the text
      if (game.widget.gameMode == GameMode.AI || game.widget.gameMode == GameMode.ONLINE) {
        // in an online game, or a game vs AI, it's clear if its your turn or the opponents turn
        if (game.board.player == game.widget.playingAs) {
          text = ".:: YOUR TURN ::.";
        } else if (game.widget.gameMode == GameMode.ONLINE) {
          text = ".:: WAITING FOR YOUR OPPONANT ::.";
        } else {
          text = ".:: AI IS THINKING ::.";
        }
      } else {
        text = ".:: WATING FOR " + game.board.player + " TO PLAY ::."; 
      }

    } else {
      /*
        if the game is finished, show the winner or looser 
      */


      // choose the animation

      // if no winners, the game is a tie
      // if its a local game, just show a tie animation
      if (finished.item2 == null || game.widget.gameMode == GameMode.LOCAL) {
        source = "assets/animations/battle/tie.flr";
      } else {
        // on a game against AI or and online game, its clear if you own or lost
        if (finished.item2 == game.widget.playingAs) {
          source = "assets/animations/battle/win.flr";
        } else {
          source = "assets/animations/battle/lose.flr";
        }
      }

      if (finished.item2 == null){
        // the game is a tie
        text = ".:: THE GAME IS A TIE ::.";
      } else {
        // choose the text
        if (game.widget.gameMode == GameMode.LOCAL) {
          text = ".:: " + finished.item2 + " IS THE WINNER ::.";
        } else {
          if (finished.item2 == game.widget.playingAs) {
            text = ".:: YOU WIN ::.";
          } else {
            text = ".:: YOU LOSE ::.";
          }
        }
      }
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
