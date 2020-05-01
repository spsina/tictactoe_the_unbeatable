import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/utils/socketConnectio.dart';

// global web socket connection
WebSocketConnection wsc;

// global uni link status
bool uniLinkUsed = false;
BuildContext gbc;

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  wsc = WebSocketConnection(url: "ws://cafepay.app:9090");


  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // to hide only bottom bar:
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.top]);

  // to hide only status bar: 
  SystemChrome.setEnabledSystemUIOverlays ([SystemUiOverlay.bottom]);

  // to hide both:
  SystemChrome.setEnabledSystemUIOverlays ([]);

  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "TIC TAC TOE, THE UNBEATABLE",
      home: BattleSelectPage()
  ));
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
    return SizedBox();
  }
}
