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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/3x3_death.png')), width: 4 * tileSize, height: 4*tileSize,),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: tileSize/ 5 ),
                width: 4 * tileSize,
                child: Text("YOU CAN NEVER WIN THIS", textAlign: TextAlign.left, style: TextStyle(
                  fontSize: tileSize / 2.1,
                  color: Color(0xffff1e56),
                ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }

}