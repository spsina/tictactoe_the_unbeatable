
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/playAs.dart';

void showPlayAsOptions(BuildContext context, int size, GameMode gameMode) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PlayAs(size, gameMode);
    },
  );
}