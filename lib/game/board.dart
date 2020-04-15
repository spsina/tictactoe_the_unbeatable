import 'package:tictactoe/game/player.dart';
import 'package:tuple/tuple.dart';


class Board{
  List<List<String>> board;             // the game board
  Set<Tuple2<int,int>> possibleMoves;   // free cells
  Tuple2<int, int> lastMove;            // last move made by a player
  Player player;                        // player who has the turn 
  int size;                             // board size
  int moves;                            // number of moves made so far
  int maxMoves;                         // max number of moves (size * size)

  Board(this.size) {
    possibleMoves = Set<Tuple2<int,int>>();

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
    
    // X starts the game
    player = Player(x);

  }

  void moveTo(i, j){
    
    // make the move
    if (board[i][j] == ""){
      board[i][j] = player.getRepresentation();
      
      lastMove = Tuple2(i,j);
      possibleMoves.remove(Tuple2(i,j));
      moves++;
      // switch the player
      if (player.type == x)
        player = Player(o);
      else
        player = Player(x);
    }

    
  }
  
}