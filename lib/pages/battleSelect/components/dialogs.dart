
import 'package:flutter/material.dart';
import 'package:tictactoe/pages/battle/battle.dart';
import 'package:tictactoe/pages/battleSelect/components/playAs.dart';

import 'customBoard.dart';

void showPlayAsOptions(BuildContext context, int size, GameMode gameMode) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return PlayAs(size, gameMode);
    },
  );
}


void showCustomBoardCreate(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return CustomBoard();
    },
  );
}

