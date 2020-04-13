import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game/game.dart';
Tictactoe game = Tictactoe();

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp());
  
  
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);

}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Learning flutter',
      home: Scaffold(
        appBar: AppBar(
          title: Text("Let's learn this thing"),
        ),
        body: Center(
          child: Text('Hello World'),
        ),
      ),
    );
  }
}
