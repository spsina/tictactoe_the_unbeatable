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
  int totalValue = 0;
  int simulations = 0;
  Node parent;
  Tuple2<int,int> move;
  List<Node> children = List();

  double avg(){
    return totalValue.toDouble() / simulations.toDouble();
  }
  double theVal(){return avg() * simulations.toDouble();}
  Node(this.board, this.totalValue, this.simulations, this.parent, this.move);
}

class AI {
  static final _random = new Random();
  static DateTime deadLine;
  static Board result(Board base, i, j){
    var r = base.clone();
    r.moveTo(i, j);
    return r;
  }

  static String aiPlayingAs = o;

  static int rollout(Board board){
    var terminated = board.terminal();
    
    if (terminated.item1){
      if (terminated.item2 == aiPlayingAs)
        return 1;
      else if (terminated == null)
        return 0;
      else
        return -1;
    }

    var nxtMove = board.possibleMoves[_random.nextInt(board.possibleMoves.length)];

    return rollout(result(board, nxtMove.item1, nxtMove.item2));
  }

  static void updateAndPropagate(Node node, int value){
    node.totalValue += value;
    node.simulations ++;
    if (node.parent != null)
      updateAndPropagate(node.parent, value);
  }
  static double ucb(Node node){
    return node.avg()+ 5 * sqrt(log(node.parent.simulations) / node.simulations);
  }
  static Node ucb1Best(List<Node> nodes){
    double bestValue = ucb(nodes[0]);
    var bestNode = nodes[0];

    for (var i = 1; i <nodes.length; i++){
      if (nodes[i].simulations == 0)
        return nodes[i];
      var val = ucb(nodes[i]);
      if (val > bestValue){
        bestValue = val;
        bestNode = nodes[i];
      }
    }

    return bestNode;
  }

  static Node traverse(Node root){

    if (root.children.length == 0)
      expand(root);

    var node = root;
    while (node.children.length > 0){
      node = ucb1Best(node.children);
    }

    return node;

  }

  static void expand(Node node) {
      node.board.getMoves().forEach((move){
      Node n = Node(result(node.board, move.item1, move.item2), 0, 0, node, move);
      node.children.add(n);
    });
  }


  static Tuple2<int,int> mcts(Board _board) {
    Board board = _board.clone();
    Node root = Node(board, 0, 0, null, null);
    int l = (50000 * (2-_board.ration())).toInt();
    for (var i = 0 ; i < l; i ++){
      var node = traverse(root);
      updateAndPropagate(node, rollout(node.board));

      // print(i.toString() + "\t/\t" + l.toString());
    }

    var bestNode = root.children.reduce((curr, next) => curr.theVal() >= next.theVal() ? curr: next);
    return bestNode.move;
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
    aiPlayingAs = board.player;

    if (board.size == 5){
      return mcts(board);
    } else if (board.size == 7) {
      deadLine= DateTime.now().add(Duration(minutes: 1));
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