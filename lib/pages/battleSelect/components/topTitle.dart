
import 'package:flutter/cupertino.dart';

class TopTitle extends StatelessWidget{
  /*
    the top title that reads:
    TIC TAC TOE
    THE UNBEATABLE
  */

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;
    return 
    Container (
      margin: EdgeInsets.only(top: tileSize * 1.2),
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // TIC TAC TOE
                Container(
                  width: 8 * tileSize,
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text( "TIC TAC TOE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                            color: Color(0xffF4F4F4),
                          ),
                      )
                  ),
                ),
                // THE UNBETABLE
                Container(
                  width: 6 * tileSize,
                  margin: EdgeInsets.only(top: tileSize / 5),
                  child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text("THE UNBEATABLE",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff8EC6C5),
                        ),
                      )
                  ),
                ),
            ],
            ),
          ],
          )
        );
  }
}
