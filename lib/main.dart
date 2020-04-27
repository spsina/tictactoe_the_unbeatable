import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/utils/socketConnectio.dart';

WebSocketConnection wsc;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  wsc = WebSocketConnection(url: "ws://cafepay.app:9090");


  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

  // to hide only status bar: 
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

  // to hide both:
  SystemChrome.setEnabledSystemUIOverlays ([]);

  runApp(Entry(BattleSelectPage()));
}

class Entry extends StatefulWidget{
  final Widget page;

  Entry(this.page);

  @override
  _EntryState createState() => _EntryState();
}

class _EntryState extends State<Entry> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "TIC TAC TOE, THE UNBEATABLE",
      home: widget.page
      );
  }
}
