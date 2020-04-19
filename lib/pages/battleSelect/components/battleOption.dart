import 'package:flutter/cupertino.dart';

class BattleOption extends StatelessWidget{
  /*
    battle option
    with text description and the image
  */
  final String imagePath;
  final Widget text;

  BattleOption(this.imagePath, this.text);

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          // image
          Container(
            width: 4 * tileSize,
            height: 4 * tileSize,
            child: Image(image: AssetImage(imagePath))
          ),
          // text
          Container(
            margin: EdgeInsets.only(left: tileSize / 10),
            width: 4 * tileSize,
            height: 4 * tileSize,
            child: text
          )
        ],
      ),
    );
  }

}