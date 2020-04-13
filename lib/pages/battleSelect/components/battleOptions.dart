import 'package:flutter/cupertino.dart';
import 'package:tictactoe/pages/battleSelect/components/3x3.dart';
import 'package:tictactoe/pages/battleSelect/components/5x5.dart';

class BattleOptions extends StatelessWidget{
  /*
    battle option
    a 3x3 and a 5x5  
  */
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 79),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          ThreeByThree(),
          FiveByFive()
        ],
      ),
    );
  }

}