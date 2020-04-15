import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/main.dart';
import 'package:tictactoe/pages/battleSelect/components/aboutBotton.dart';
import 'package:tictactoe/pages/battleSelect/components/battleOptions.dart';
import 'package:tictactoe/pages/battleSelect/components/topTitle.dart';
import 'package:tictactoe/pages/win/win.dart';

class BattleSelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return
      Container(
        child: Column(
          children: <Widget>[
              TopTitle(),
              BattleOptions(),
              Expanded(
                  child: Align(
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Entry(WinPage(3))),
                        );
                      },
                      child: AboutButton(),
                    ),
                    alignment: FractionalOffset.bottomCenter,
                ),
              ),
            ],
          ),
      );
  }

}