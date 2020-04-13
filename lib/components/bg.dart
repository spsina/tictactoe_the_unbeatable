import 'dart:ui';
import 'package:flame/flame.dart';
import 'package:flame/sprite.dart';
import 'package:tictactoe/game/game.dart';


class Background {
  Rect bgRect;
  Sprite bgSprite;
  Tictactoe game;

  Background(Tictactoe game, Image image) {
    
    bgSprite = Sprite.fromImage(image);

    // create the bgRect
    bgRect = Rect.fromLTWH(
        0, 
        game.screenSize.height - bgSprite.image.height.toDouble(), 
        bgSprite.image.width.toDouble(), 
        bgSprite.image.height.toDouble(), 
      );
  }

  void render(Canvas canvas){
    bgSprite.renderRect(canvas, bgRect);
  }

  void update(double t){

  }
}