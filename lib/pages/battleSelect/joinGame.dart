import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:tictactoe/pages/generic/helper.dart';

import 'battleSelect.dart';

class JoinGame extends StatefulWidget{
  @override
  _JoinGameState createState() => _JoinGameState();
}

class _JoinGameState extends State<JoinGame> {
  bool loading = false;

  var buttonChild;

  @override
  Widget build(BuildContext context) {
    double tileSize = MediaQuery. of(context).size.width / 9;
    return Scaffold(
      backgroundColor: Color(0xff1B2429),
      body: Container(
        margin: EdgeInsets.only(top: tileSize * 1.2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: Container(
                width: 8 * tileSize,
                child: FittedBox(
                    fit: BoxFit.contain,
                    child: Text( "JOIN AN ONLINE GAME",
                      style: TextStyle(
                        color: Color(0xffF4F4F4),
                      ),
                    )
                ),
              ),
            ),
            Container (
              child: Column (
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Color(0xff000000),
                              blurRadius: 20.0, // has the effect of softening the shadow
                              spreadRadius: 5.0, // has the effect of extending the shadow
                            )
                          ]
                      ),
                      margin: EdgeInsets.only(top:30),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Container(
                                width: 200,
                                child: TextField(
                                  style: TextStyle(color: Colors.white),
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    border: InputBorder.none,
                                    hintText: 'Enter a search term'
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      )
                  ),
                  InkWell(
                    onTap: () {
                      if (loading)
                        return;
                    },
                    child: Container(
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(10),
                      color: Color(0xffff1e56),
                      child: Center(
                        child: buttonChild,
                      ),
                    ),
                  )
                ],
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