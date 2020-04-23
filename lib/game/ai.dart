import 'package:tictactoe/game/board.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';
const double infinity = 1.0 / 0.0;

Board result(Board base, i, j){
  var r = base.clone();
  r.moveTo(i, j);
  return r;
}

int dist(Tuple2<int,int> p1, Tuple2<int,int> p2){
  int dx = p1.item1 - p2.item1;
  int dy = p1.item2 - p2.item2;

  return dx*dx + dy*dy;
}

int cmp(Tuple2<int, int > p1, Tuple2<int ,int > p2, Tuple2<int,int> base){
  int d1 = dist(p1, base);
  int d2 = dist(p2, base);

  return d1 - d2;
}

Tuple2<double, Tuple2<int, int>> maxValue(Board board, double alpha, double beta, int depth){
  var terminated = board.terminal();
  if (terminated.item1 || depth == 0)
    return Tuple2(board.utility().toDouble(), null);
  
  double value = - infinity;
  var bestMove;

  board.possibleMoves.sort( (a, b) {
    return cmp(a, b, board.lastMove);
  });

  for (var move in board.possibleMoves){
    var data = minValue(result(board, move.item1, move.item2), alpha, beta, depth - 1);
    
    if (data.item1 > value){
      value = data.item1;
      bestMove = move;
    }

    alpha = value > alpha ? value : alpha;

    if (alpha > beta)
      break;

  }

  return Tuple2(value, bestMove);
}

Tuple2<double, Tuple2<int, int>> minValue(Board board, double alpha, double beta, int depth){
  var terminated = board.terminal();
  if (terminated.item1 || depth == 0)
    return Tuple2(board.utility().toDouble(), null);
  
  double value = infinity;
  var bestMove;
  
  board.possibleMoves.sort( (a, b) {
    return cmp(a, b, board.lastMove);
  });

  for (var move in board.possibleMoves){
    var data = maxValue(result(board, move.item1, move.item2), alpha, beta, depth - 1);
    
    if (data.item1 < value){
      value = data.item1;
      bestMove = move;
    }

    beta = value < beta ? value : beta;
    if (alpha > beta)
      break;

  }

  return Tuple2(value, bestMove);
}


Tuple2 <int, int> alphabeta(Board board){
  // opening move
  if (board.possibleMoves.length == board.maxMoves){
    // you are the starter of the game
    // choose the middle
    int middle = board.size ~/ 2;
    return Tuple2(middle, middle);
  }
  // if it's the first move, always place a symbol diagonal to the opponent
  else if (board.possibleMoves.length == board.maxMoves -1){
      var theMoves = List();
      for (var i = -1; i<2; i+=2) {
        for (var j = -1; j < 2;j+=2) {
          // this generates all the four possible diagonal positions of the last move
          var pos = Tuple2(board.lastMove.item1 + i, board.lastMove.item2 + j);
          if (board.possibleMoves.contains(
              // the generated position may not be avalibale
              // depending on the position of the last move
              // so check first
              pos))

            // store the available position, to select a random later
            theMoves.add(pos);
        }
      }
      // this does not happen, but if no moves, just ignore the opening
      // strategy and let the ai choose the opening move
      if (theMoves.length > 0) {
        int index = Random().nextInt(theMoves.length - 1);
        return theMoves[index];
      }
    }

  int d = inf;
  if (board.size == 3) {
    int d = inf;
  } else if (board.size == 5){
    if (board.ration() > 0.8)
      d = 5;
    else if (board.ration() > 0.3)
      d = 5;
    else if (board.ration() <= 0.3)
      d = inf;
  } else{
    if (board.ration() > 0.8)
      d = 4;
    else if (board.ration() > 0.2)
      d = 4;
    else if (board.ration() <= 0.2)
      d = inf;
  }


  if (board.player == x)
    return maxValue(board, -infinity, infinity, d).item2;
  
  return minValue(board, -infinity, infinity, d).item2;
}