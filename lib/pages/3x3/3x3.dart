import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/pages/generic/turn.dart';

class ThreeByThreeGameBoard extends StatefulWidget {
  /*
    The 3x3 game board
  */
  Player player;

  ThreeByThreeGameBoard(this.player);

  ThreeByThreeState createState() => ThreeByThreeState();
}


class ThreeByThreeState extends State<ThreeByThreeGameBoard> {
  
  @override
  Widget build(BuildContext context) {
    // get the player 
    Player player = widget.player;
    
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Trun(player)
        ],
      ),
    );
  }

}