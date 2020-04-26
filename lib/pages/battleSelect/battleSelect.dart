import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/components/aboutBotton.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptions.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';
import 'package:tictactoe/pages/battleSelect/joinGame.dart';
import 'package:tictactoe/pages/generic/helper.dart';

import 'components/dialogs.dart';
import 'customBoardPage.dart';

class BattleSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;

    return Scaffold(
      backgroundColor: Color(0xff1B2429),
      body: Container(
        child: Column(
          children: <Widget>[
            TopTitle(),
            Expanded(
              flex: 4,
              child: BattleOptions(),
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
            child: Icon(Icons.group_add),
            backgroundColor: Colors.red,
            label: 'PLAY WITH A FIREND',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: ()=> navigate(context, JoinGame())
          ),
          SpeedDialChild(
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.blue,
            label: 'CUSTOM BOARD',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: () => navigate(context, CustomBoardPage())
          ),
          SpeedDialChild(
            child: Icon(Icons.info),
            backgroundColor: Colors.green,
            label: 'ABOUT US',
            labelStyle: TextStyle(fontSize: 14.0),
          ),
        ],
      ),
    );
  }

}