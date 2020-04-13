import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:tictactoe/components/bg.dart';

class Tictactoe extends Game{
  Size screenSize;
  double tileSize;
  Background background;

  bool allSystemsInitialized = false;

  Tictactoe(){
    init();
  }

  void init() async{
    // wait for the lucnch to get the dimentions
    resize(await Flame.util.initialDimensions() );

    // prepare the background
    background = Background(this, await Flame.images.load('bg/bg.jpg'));


    allSystemsInitialized = true;
  }

  void render(Canvas canvas) {
    if (allSystemsInitialized){

      // render the background first
      background.render(canvas);

    }
  }

  void update(double t) {
    if (allSystemsInitialized){

      // render the background first
      background.update(t);
      
    }
  }

  void resize(Size size){
    screenSize = size;
    tileSize = screenSize.width / 9;

    super.resize(size);
  }

}