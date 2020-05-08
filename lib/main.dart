import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/utils/firebaseMessage.dart';
import 'package:tictactoe/utils/socketConnectio.dart';
import 'package:tictactoe/utils/universalLinks.dart';

// global web socket connection
WebSocketConnection wsc;

// global navigator
GlobalKey<NavigatorState> navigatorKey;

// global notifier
Notifier notifier;

// global universal links dispatcher
UniversalLinks ul;


void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // setup
  wsc = WebSocketConnection(url: "ws://cafepay.app:9090");
  navigatorKey = GlobalKey<NavigatorState>();
  notifier = Notifier();
  ul = UniversalLinks();

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