
import 'package:flutter/cupertino.dart';

class TopTitle extends StatelessWidget{
  /*
    the top title that reads:
    TIC TAC TOE
    THE UNBEATABLE
  */
  
  @override
  Widget build(BuildContext context) {
    return 
    Container (
      margin: const EdgeInsets.only(top: 53),
      child: 
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                // TIC TAC TOE
                Container(
                  child: Text("TIC TAC TOE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF4F4F4),
                      fontSize: 37
                      ),
                      )
                ),
                // THE UNBETABLE
                Container(
                  margin: EdgeInsets.only(top: 13),
                  child: Text("THE UNBEATABLE",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xff8EC6C5),
                      fontSize: 23
                      ),
                      )
                ),
            ],
            ),
          ],
          )
        );
  }
}
