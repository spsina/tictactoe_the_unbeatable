import 'dart:ui';
import 'package:flame/game.dart';
import 'package:flame/flame.dart';
import 'package:tictactoe/components/battleSelect.dart';
import 'package:tictactoe/components/page.dart';

class Tictactoe extends Game{
  Size screenSize;
  double tileSize;
  Page page;
  bool allSystemsInitialized = false;

  Tictactoe(){
    init();
  }

  void init() async{
    // wait for the lucnch to get the dimentions
    resize(await Flame.util.initialDimensions() );
    page = BattleSelectPage(this);

    // flareAnimation = await FlareAnimation.load("assets/animations/battleSelect/select.flr");
    // flareAnimation.updateAnimation("Alarm");

    // flareAnimation.width = 200;
    // flareAnimation.height = 200;

    allSystemsInitialized = true;
  }

  void render(Canvas canvas) {
    if (allSystemsInitialized){
      
      page.render(canvas);

    }
  }

  void update(double t) {
    if (allSystemsInitialized){


    }
  }

  void resize(Size size){
    screenSize = size;
    tileSize = screenSize.width / 9;

    super.resize(size);
  }

}