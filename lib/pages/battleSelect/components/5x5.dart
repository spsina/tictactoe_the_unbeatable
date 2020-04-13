import 'package:flutter/cupertino.dart';

class FiveByFive extends StatelessWidget{
  /*
    3x3 battle option
    with text description and the image
  */
  @override
  Widget build(BuildContext context) {
    return Image(image: AssetImage(('assets/images/battleSelect/5x5_challenge.png')), width: 200, height: 200,);
  }

}