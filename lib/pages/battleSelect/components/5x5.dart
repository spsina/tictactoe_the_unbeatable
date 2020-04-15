import 'package:flutter/cupertino.dart';

class FiveByFive extends StatelessWidget{
  /*
    5x5 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Container(
      margin: EdgeInsets.only(top: tileSize),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/5x5_challenge.png')), width: 4 * tileSize, height: 4 * tileSize,),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.only(top: tileSize/ 5 ),
                width: 4 * tileSize,
                child: Text("THER IS A CHANCE HERE", textAlign: TextAlign.left, style: TextStyle(
                  fontSize: tileSize / 2.1,
                  color: Color(0xffffac41)
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