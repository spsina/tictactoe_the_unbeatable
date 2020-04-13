import 'package:flutter/material.dart';
import 'package:flame/util.dart';
import 'package:flutter/services.dart';
import 'package:tictactoe/game/game.dart';

void main() {
  Util flameUtil = Util();
  flameUtil.fullScreen();
  flameUtil.setOrientation(DeviceOrientation.portraitUp);
  Tictactoe game = Tictactoe();

  runApp(game.widget);
}
