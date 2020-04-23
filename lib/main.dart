import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

  // to hide only status bar: 
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

  // to hide both:
  SystemChrome.setEnabledSystemUIOverlays ([]);

  runApp(Entry(BattleSelectPage()));
}

class Entry extends StatelessWidget{
  final Widget page;
  
  Entry(this.page);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "TIC TAC TOE, THE UNBEATABLE",
      home: page
      );
  }

}
