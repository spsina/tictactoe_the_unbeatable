import 'package:flutter/cupertino.dart';

class ThreeByThree extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      child: Column(
        children: <Widget>[
          Image(image: AssetImage(('assets/images/battleSelect/3x3_death.png')), width: 180, height: 180,),
          Container(
            margin: EdgeInsets.only(top: 37, bottom: 15),
            child: Text("3x3", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 35,
              color: Color(0xffff1e56)
            ),
            ),
          ),
          Container(
            width: 118,
            child: Text("YOU CAN NEVER WIN THIS", textAlign: TextAlign.center, style: TextStyle(
              fontSize: 20,
              color: Color(0xffff1e56)
            ),
            ),
          )
        ],
      ),
    );
  }

}