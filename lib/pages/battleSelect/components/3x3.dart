import 'package:flutter/cupertino.dart';

class ThreeByThree extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(('assets/images/battleSelect/3x3_death.png')), width: 200, height: 200,);
  }

}