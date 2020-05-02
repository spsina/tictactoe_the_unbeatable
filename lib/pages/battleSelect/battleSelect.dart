import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptions.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';
import 'package:tictactoe/pages/battleSelect/joinGame.dart';
import 'package:tictactoe/pages/generic/helper.dart';
import 'package:uni_links/uni_links.dart';
import 'customBoardPage.dart';

class BattleSelectPage extends StatefulWidget{

  @override
  _BattleSelectPageState createState() => _BattleSelectPageState();
}

class _BattleSelectPageState extends State<BattleSelectPage> {
  final _battleOption = BattleOptions();


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
              flex: 10,
              child: _battleOption,
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: IconButton(
                  onPressed: () {
                    _battleOption.controller.animateTo(
                      _battleOption.controller.position.maxScrollExtent,
                      duration: Duration(milliseconds: 1000),
                      curve: Curves.ease,
                    );
                  },
                  icon: Icon(Icons.arrow_drop_down, color: Colors.white,),
                ),
              ),
            )
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
            onTap: ()=> navigate( JoinGame(), false)
          ),
          SpeedDialChild(
            child: Icon(Icons.add_circle),
            backgroundColor: Colors.blue,
            label: 'CUSTOM BOARD',
            labelStyle: TextStyle(fontSize: 14.0),
            onTap: () => navigate( CustomBoardPage(),false)
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