import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game/player.dart';
import 'package:tictactoe/pages/3x3/3x3.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

  // to hide only status bar: 
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

  // to hide both:
  SystemChrome.setEnabledSystemUIOverlays ([]);

  runApp(Entry());
}

class Entry extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "TIC TAC TOE, THE UNBEATABLE",
      home: Scaffold(
        backgroundColor: Color(0xff1B2429),
        body: ThreeByThreeGameBoard(Player(PlayerType.X))
        )
      );
  }

}
