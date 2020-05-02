import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/pages/battleSelect/battleSelect.dart';
import 'package:tictactoe/pages/battleSelect/joinGame.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:tictactoe/utils/socketConnectio.dart';
import 'package:uni_links/uni_links.dart';

// global web socket connection
WebSocketConnection wsc;
final GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

// set up the universal links listener
Future<Null> initUniLinks() async {
  try {
    getLinksStream().listen(parseLink, onError: (err) {});
    parseLink(await getInitialLink());
  } catch (err) {}
}

// parse incoming links
void parseLink(String link) async {
  try {
    if (link != null) {
      Uri uri = Uri.parse(link);
      String gameId = uri.queryParameters['gameId'];
      navigate(JoinGame(initialGameId: gameId), false);
    }
  } catch(err) {}
}

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

  initUniLinks();

  runApp(MaterialApp(
      theme: ThemeData(fontFamily: 'Gearus'),
      title: "TIC TAC TOE, THE UNBEATABLE",
      home: BattleSelectPage(),
      navigatorKey: navigatorKey,
  ));
}