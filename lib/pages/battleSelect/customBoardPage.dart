import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';
import 'package:tictactoe/pages/generic/helper.dart';

import 'battleSelect.dart';
import 'components/customBoard.dart';

class CustomBoardPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Scaffold(
      backgroundColor: Color(0xff1B2429),
      body: Container(
        margin: EdgeInsets.only(top: tileSize * 1.2),

        child: Column(
          children: <Widget>[
            Container(
              width: 8 * tileSize,
              child: FittedBox(
                  fit: BoxFit.contain,
                  child: Text( "PLAY A CUSTOM BOARD",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xffF4F4F4),
                    ),
                  )
              ),
            ),
            Container(
              margin: EdgeInsets.all(20),
              child: CustomBoard(),
            ),
          ],
        ),
      ),
      floatingActionButton: SpeedDial(
        // both default to 16
        marginRight: 18,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22.0),
        visible: true,
        closeManually: false,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 8.0,
        shape: CircleBorder(),
        children: [
          SpeedDialChild(
              child: Icon(Icons.home),
              backgroundColor: Colors.red,
              label: 'HOME',
              labelStyle: TextStyle(fontSize: 14.0),
              onTap: () {
                navigate(context, BattleSelectPage());
              }
          ),
        ],
      ),
    );
  }

}