import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/battleSelect/joinGame.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:uni_links/uni_links.dart';
import 'package:web_socket_channel/io.dart';



void main() async{
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
      home: JoinGame()
      );
  }

}
