import 'package:tictactoe/game/board.dart';
import 'package:tuple/tuple.dart';
import "dart:math";

var list = ['a','b','c','d','e'];

// generates a new Random object

class _Cache {
    int value;
    Tuple2<int, int> move;
    
    _Cache( this.value, this.move);
}

class Node {
  Board board;
  String player;
  int wins = 0;
  int simulations = 0;
  Node parent;
  Tuple2<int,int> move;
  List<Node> children = List();

  Node(this.board, this.player, this.wins, this.simulations, this.parent, this.move, [this.children]);
}

class AI {
  static final _random = new Random();

  static Board result(Board base, i, j){
    var r = base.clone();
    r.moveTo(i, j);
    return r;
  }

  static String playout(Board board){
    var terminated = board.terminal();
    if (terminated.item1){
      return terminated.item2;
    }

    var nxtMove = board.possibleMoves[_random.nextInt(board.possibleMoves.length)];

    return playout(result(board, nxtMove.item1, nxtMove.item2));
  }

  static void updateAndPropagate(Node node, bool isWin){
    if (isWin)
      node.wins++;
    node.simulations ++;

    if (node.parent != null)
      updateAndPropagate(node.parent, isWin);
  }

  static void execute(Node node){
    var playOutResult = playout(node.board);
    if (playOutResult == node.player || playOutResult == null)
      updateAndPropagate(node, true);
    updateAndPropagate(node, false);
  }

  static Node pickUnvisited(Node node){
    
  }

  static Tuple2<int,int> mcts(Board _board) {
    Board board = _board.clone();
    var pl = board.player;
    Node root = Node(board, board.player, 0,0,null, null);

    // initialize
    board.possibleMoves.forEach((move){
      Node n = Node(result(board, move.item1, move.item2),
       board.player, 0, 0, root, move);
      root.children.add(n);
      execute(n);
    });


  }

  static bool useCache = true;

  static int maxHit = 0;
  static int minHit = 0;

  static final Map<String, _Cache> maxCache = Map();
  static final Map<String, _Cache> minCache = Map();

  static Tuple2<int, Tuple2<int, int>> maxValue(Board board, int alpha, int beta, int depth){
    var terminated = board.terminal();
    if (terminated.item1){
      print("Depth2: " + depth.toString());
      return Tuple2(board.utility(), null);
    }
    
    int value = - inf * inf;
    var bestMove;

    for (var move in board.possibleMoves){
      // lookup the chache
      var r = result(board, move.item1, move.item2);
      var data;
      if (data == null)
        data = minValue(r, alpha, beta, depth + 1);
      
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

  static Tuple2<int, Tuple2<int, int>> minValue(Board board, int alpha, int beta, int depth){
    var terminated = board.terminal();
    if (terminated.item1) {
      print("Depth: " + depth.toString());
      return Tuple2(board.utility(), null);
    }
    
    int value = inf * inf;
    var bestMove;
    
    for (var move in board.possibleMoves){     
      var r = result(board, move.item1, move.item2);
      var data;
      if (data == null)
        data = maxValue(r, alpha, beta, depth + 1);
      
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


  static Tuple2 <int, int> alphabeta(Board board){

    int d = inf;

    if (board.size == 5){
      if (board.ration() > 0.8)
        d = 5;
      else if (board.ration() > 0.3)
        d = 5;
      else if (board.ration() <= 0.3)
        d = inf;
    } else if (board.size == 7) {
      return mcts(board);
    }


    useCache = true;
    if (board.player == x) {
      var response = maxValue(board, -inf, inf, d).item2;
      print ("Max Hit: " +maxHit.toString() );
      print ("Min Hit: " + minHit.toString());
      print ("Response: " + response.toString());

      return response;
    } else {
      var response = minValue(board, -inf, inf, d).item2;
      print ("Max Hit: " +maxHit.toString() );
      print ("Min Hit: " + minHit.toString());
      print ("Response: " + response.toString());
      return response;
    }
  }

}