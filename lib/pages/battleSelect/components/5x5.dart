import 'package:flutter/cupertino.dart';

class FiveByFive extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/5x5_challenge.png')), width: 180, height: 180,),
          Container(
            margin: EdgeInsets.only(top: 37, bottom: 15),
            child: Text("5x5", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 35,
              color: Color(0xffffac41)
            ),
            ),
          ),
          Container(
            width: 140,
            child: Text("THER IS A CHANCE HERE", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 20,
              color: Color(0xffffac41)
            ),
            ),
          )
        ],
      ),
    );
  }

}