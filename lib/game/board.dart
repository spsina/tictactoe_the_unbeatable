import 'package:tuple/tuple.dart';

var x = "X";
var o = "O";

class Board{
  List<List<String>> board;             // the game board
  List<Tuple2<int,int>> possibleMoves;   // free cells
  Tuple2<int, int> lastMove;            // last move made by a player
  String player;                        // player who has the turn 
  int size;                             // board size
  int moves;                            // number of moves made so far
  int maxMoves;                         // max number of moves (size * size)

  Board clone(){
    // return a clone of this board
    
    Board cloned = Board(size, player);
    cloned.moves = moves; cloned.maxMoves = maxMoves;
    cloned.lastMove = Tuple2(lastMove.item1, lastMove.item2);

    cloned.possibleMoves = List<Tuple2<int,int>>.generate(possibleMoves.length, (i){
      return Tuple2(possibleMoves[i].item1, possibleMoves[i].item2);
    });

    cloned.board = List<List<String>>.generate(board.length, (i){
      return List<String>.generate(board[i].length, (j){
        return board[i][j];
      });
    });

  }

  Board(this.size, this.player) {
    possibleMoves = List<Tuple2<int,int>>();

    // setup the board
    board = List<List<String>>.generate(size, (i) {
        return List<String>.generate(size, (j) {
          
          // add this cell to free celss
          possibleMoves.add(Tuple2(i,j));

          return "";
        }); 
      }
    );
    maxMoves = size * size;

    // no last move yet
    lastMove = Tuple2<int, int>(-1, -1);
    
    // no moves yet
    moves = 0;

  }

  void moveTo(i, j){
    
    // make the move
    if (board[i][j] == ""){
      board[i][j] = player;
      
      lastMove = Tuple2(i,j);
      possibleMoves.remove(Tuple2(i,j));
      moves++;
      // switch the player
      if (player == x)
        player = o;
      else
        player =x;
    }

  }

}