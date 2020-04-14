import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/pages/generic/turn.dart';



class GameBoard extends StatefulWidget {
  /*
    The 3x3 game board
  */
  final Player player;
  final int size;

  GameBoard(this.player, this.size);

  ThreeByThreeState createState() => ThreeByThreeState();
}


class ThreeByThreeState extends State<GameBoard> {
  
  List<List<String>> _board;
  
  @override
  void initState() {
      _board = List<List<String>>.generate(widget.size, (i) { 
        return List<String>.generate(widget.size, (j) => ""); 
      });
      super.initState();
  }

  Widget _visualizedBoard() {
    return Container( 
      margin: EdgeInsets.all(15),
      child: Column(
      children: List<Widget>.generate(widget.size,
       (i) => Container(
         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
         children: List<Widget>.generate(widget.size,
          (j) => GestureDetector(
            onTap: () {
              setState(() {
                _board[i][j] = "X";
              });
            },
            child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              color: Color(0xff323232),
            ),
            width:  widget.size == 3 ? 100 : 100 * 3/5,
            height: widget.size == 3 ? 100 : 100 * 3/5,
            margin: EdgeInsets.only(right: 10, top:10),
            child: Center(child: Text(_board[i][j],
            style: TextStyle(
                color: Color(0xfff4f4f4),
                fontSize: 45
              ),
            )
          )
          )
          ),
         )
        )
    )
    )
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    // get the player 
    Player player = widget.player;
    return Container(
      child: Column(
        children: <Widget>[
          Trun(player),
          _visualizedBoard()
        ],
      ),
    );
  }

}