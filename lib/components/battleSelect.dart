import 'dart:ui';

import 'package:flame/flame.dart';
import 'package:flame/position.dart';
import 'package:flame/sprite.dart';
import 'package:tictactoe/components/bg.dart';
import 'package:tictactoe/components/page.dart';
import 'package:tictactoe/game/game.dart';


class BattleSelectPage extends Page{
  Rect pageRect;
  Background background;
  Tictactoe game;

  List<Sprite> elemnts;
  List<Image> assets;

  bool allSystemsInitialized = false;

  BattleSelectPage(Tictactoe igame) {
    game = igame;
    init();
  }

 
  void init() async {
      // init elemnts
      elemnts = <Sprite>[];
      assets = await Flame.images.loadAll(<String>[
        'bg/bg.jpg',
        'battleSelect/3x3_death.png',
        'battleSelect/10x10_challenge.png',
        'battleSelect/choose_your_battle.png'
      ]);
      
      // load elemnts
      assets.forEach((Image image) => elemnts.add(Sprite.fromImage(image)));

      // backgroud
      background = Background(game, assets[0]);

      // choose your battle
      allSystemsInitialized = true;
  }

  void render(Canvas canvas){
    if (allSystemsInitialized) {
      // background.render(canvas);
      Rect r = Rect.fromLTWH(0, 0, game.screenSize.width, game.screenSize.height);
      double cw = game.tileSize * 7;
      elemnts[3].renderRect(canvas, Rect.fromLTWH(game.tileSize, game.tileSize, cw, cw / 3.93) );
    }
  }

  void update(double t){
    if (allSystemsInitialized) {
      // code here
    }
  }
}