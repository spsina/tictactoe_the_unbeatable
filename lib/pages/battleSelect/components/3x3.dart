import 'package:flutter/cupertino.dart';

class ThreeByThree extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return 
    Container(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/3x3_death.png')), width: 4 * tileSize, height: 4*tileSize,),
          Container(
            margin: EdgeInsets.only(top: tileSize/ 5 ),
            child: Text("3x3", textAlign: TextAlign.center, style: TextStyle(
              fontSize: tileSize / 1.2,
              color: Color(0xffff1e56)
            ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: tileSize/ 5 ),
            width: 4 * tileSize,
            child: Text("YOU CAN NEVER WIN THIS", textAlign: TextAlign.center, style: TextStyle(
              fontSize: tileSize / 2,
              color: Color(0xffff1e56)
            ),
            ),
          )
        ],
      ),
    );
  }

}