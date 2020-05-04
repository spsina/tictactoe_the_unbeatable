import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/utils/firebaseMessage.dart';
import 'package:tictactoe/utils/socketConnectio.dart';
import 'package:tictactoe/utils/tapSell.dart';
import 'package:tictactoe/utils/universalLinks.dart';

// global web socket connection
WebSocketConnection wsc = WebSocketConnection(url: "ws://cafepay.app:9090");

// global navigator
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

// global notifier
Notifier notifier = Notifier();

// global universal links dispatcher
UniversalLinks ul = UniversalLinks();

// native tapsell api
Tapsell tapsell = Tapsell();


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // portrait mode only
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

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
      home: BattleSelectPage(),
      navigatorKey: navigatorKey,
    );
  }
}