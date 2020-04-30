import 'package:tictactoe/game/board.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';
const double infinity = 1.0 / 0.0;

class AI {

  static int level;

  static double get takeFactor {
    if (level >= 3)
      return 1.0;
    else if (level == 2)
      return 0.2;
    return 0.1;
  }

  static int takeCount(int total) {
    return (total * takeFactor).ceil();
  }

  static Board result(Board base, i, j){
    var r = base.clone();
    r.moveTo(i, j);
    return r;
  }

  static int dist(Tuple2<int,int> p1, Tuple2<int,int> p2){
    int dx = p1.item1 - p2.item1;
    int dy = p1.item2 - p2.item2;

    return dx*dx + dy*dy;
  }

  static int cmp(Tuple2<int, int > p1, Tuple2<int ,int > p2, Tuple2<int,int> base){
    int d1 = dist(p1, base);
    int d2 = dist(p2, base);

    return d1 - d2;
  }

  static Tuple2<double, Tuple2<int, int>> maxValue(Board board, double alpha, double beta, int depth){
    var terminated = board.terminal();
    if (terminated.item1 || depth == 0)
      return Tuple2(board.utility().toDouble(), null);

    double value = - infinity;
    var bestMove;

    board.possibleMoves.sort( (a, b) {
      return cmp(a, b, board.lastMove);
    });

    for (var move in board.possibleMoves.take(takeCount(board.possibleMoves.length))){
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

  static Tuple2<double, Tuple2<int, int>> minValue(Board board, double alpha, double beta, int depth){
    var terminated = board.terminal();
    if (terminated.item1 || depth == 0)
      return Tuple2(board.utility().toDouble(), null);

    double value = infinity;
    var bestMove;

    board.possibleMoves.sort( (a, b) {
      return cmp(a, b, board.lastMove);
    });

    for (var move in board.possibleMoves.take(takeCount(board.possibleMoves.length))){
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


  static Tuple2 <int, int> alphaBeta(Tuple2 args){
    Board board = args.item1;
    level = args.item2;


    // no opening strategy if level is below 3
    if (level >= 3 && board.winCount == 4 && board.size > 5) {
      // opening move
      if (board.possibleMoves.length == board.maxMoves) {
        // you are the starter of the game
        // choose the middle
        int middle = board.size ~/ 2;
        return Tuple2(middle, middle);
      }
      // if it's the first move, always place a symbol diagonal to the opponent
      else if (board.possibleMoves.length >= board.maxMoves - 1) {
        var theMoves = List();
        for (var i = -1; i < 2; i += 2) {
          for (var j = -1; j < 2; j += 2) {
            // this generates all the four possible diagonal positions of the last move
            var pos = Tuple2(board.lastMove.item1 + i, board.lastMove.item2 + j);
            if (board.possibleMoves.contains(
              // the generated position may not be available
              // depending on the position of the last move
              // so check first
                pos))
              // store the available position, to select a random later
              theMoves.add(pos);
          }
        }
        // this does not happen, but if no moves, just ignore the opening
        // strategy and let the ai choose the opening move
        if (theMoves.length > 1) {
          int index = Random().nextInt(theMoves.length - 1);
          return theMoves[index];
        } else if (theMoves.length == 1) {
          return theMoves[0];
        }
      }
    }


    int d = level;

    if (board.ration() <= 0.4)
      d += 1;

    if (board.player == x)
      return maxValue(board, -infinity, infinity, d).item2;

    return minValue(board, -infinity, infinity, d).item2;
  }
}