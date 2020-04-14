import 'package:flutter/cupertino.dart';

class FiveByFive extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/5x5_challenge.png')), width: 4 * tileSize, height: 4 * tileSize,),
          Container(
            margin: EdgeInsets.only(top: tileSize/ 5 ),
            child: Text("5x5", textAlign: TextAlign.center, style: TextStyle(
              fontSize: tileSize / 1.2,
              color: Color(0xffffac41)
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: tileSize/ 5 ),
            width: 4 * tileSize,
            child: Text("THER IS A CHANCE HERE", textAlign: TextAlign.center, style: TextStyle(
              fontSize: tileSize / 2,
              color: Color(0xffffac41)
            ),
            ),
          )
        ],
      ),
    );
  }

}