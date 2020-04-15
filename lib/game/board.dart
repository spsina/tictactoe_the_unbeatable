import 'package:tictactoe/game/player.dart';
import 'package:tuple/tuple.dart';

var x = PlayerType.X;
var o = PlayerType.O;

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
      
      possibleMoves.remove(Tuple2(i,j));
      moves++;
    }

    // switch the player
    if (player.type == x)
      player = Player(o);
    else
      player = Player(x);
  }

  int countInRow(String target, int row){
    // count target in row
    int count = 0;
    board[row].forEach((cell) => cell == target ? count++ : count += 0);

    return count;
  }

  int countInCol(String target, int col) {
    // count target in col
    int count = 0;
    for (var i = 0; i < size; i ++ )
      board[i][col] == target ? count++ : count+=0;
    
    return count;
  }

  int countInMainAxis(String target) {
    // count in main axis
    int count = 0;
    for (var i = 0 ; i < size; i++)
      board[i][i] == target ? count ++ : count += 0;

    return count;
  }

  int countInCrossAxis(String target) {
    // count in cross axis
    
    int count = 0;
    for (var i = 0 ; i < size; i++)
      board[i][size - 1 - i] == target ? count ++ : count += 0;

    return count;
  }

  Tuple2<bool, Player> finished(){
    // check to see if game is finished,
    // either we have a winner or, board is full

    // check if the last played move, makes a win
    int i = lastMove.item1; int j = lastMove.item2;
    String move = board[i][j];
    Player candidate = Player(move == "X" ? x : o);

    // winner by row
    if (countInRow(move, i) == size)
      return Tuple2(true, candidate);
    
    // winner by col
    if (countInRow(move, i) == size)
      return Tuple2(true, candidate);

    // if on axix, check for winner by axis
    if (i == j || i == (size - 1 - i)){
      if (countInMainAxis(move) == size)
        return Tuple2(true, candidate);
      
      if (countInCrossAxis(move) == size)
        return Tuple2(true, candidate);
    }

    // no winners, check board
    if (moves == maxMoves)
      return Tuple2(true, null);
    
    // game is not finished
    return Tuple2(false, null);

  }

}