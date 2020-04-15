import 'package:tictactoe/game/player.dart';
import 'package:tuple/tuple.dart';
var X = "X";
var O = "O";

String _player(List< List < String > > board) {
  int cx = 0;
  int co = 0;

  board.forEach((row) {
    row.forEach((cell) {
      if (cell == X)
        cx++;
      else if (cell == O)
        co++;
    });
  });

  if (cx <= co)
    return X;
  
  return O;
}

List< List < String > > result(List< List < String > >board, ii, jj){
    List< List < String > > newBoard;
    newBoard = List<List<String>>.generate(board.length, (i) {
        return List<String>.generate(board[i].length, (j) {
          return board[i][j];
        }); 
      });
    
    newBoard[ii][jj] = _player(board);

    return newBoard;
}


List<Tuple2<int,int>> actions(List< List < String > > board){
  List<Tuple2<int,int>> acts = List();

  for (var i = 0; i < board.length; i++){
    for (var j = 0; j< board[i].length;j++){
      if (board[i][j] == ""){
        acts.add(Tuple2(i,j));
      }
    }
  }

  return acts;
}

int countInRow(List< List < String > > board, String target, int row){
    // count target in row
    int count = 0;
    board[row].forEach((cell) => cell == target ? count++ : count += 0);

    return count;
}

int countInCol(List< List < String > > board, String target, int col) {
  // count target in col
  int count = 0;
  for (var i = 0; i < board.length; i ++ )
    board[i][col] == target ? count++ : count+=0;
  
  return count;
}

int countInMainAxis(List< List < String > > board, String target) {
  // count in main axis
  int count = 0;
  for (var i = 0 ; i < board.length; i++)
    board[i][i] == target ? count ++ : count += 0;

  return count;
}

int countInCrossAxis(List< List < String > > board, String target) {
  // count in cross axis
  
  int count = 0;
  for (var i = 0 ; i < board.length; i++)
    board[i][board.length - 1 - i] == target ? count ++ : count += 0;
  
  return count;
}

Tuple2<bool, Player> terminal(List< List < String > > board){
  // check to see if game is finished,
  // either we have a winner or, board is full

  // check if the last played move, makes a win
  
  // winner by row
  for (var i = 0 ; i < board.length; i++){
    if (countInRow(board, "X", i) == board.length)
      return Tuple2(true, Player(x));
    
    if (countInRow(board, "O", i) == board.length)
      return Tuple2(true, Player(o));
  }
  
  for (var i = 0 ; i < board.length; i++){
    if (countInCol(board, "X", i) == board.length)
      return Tuple2(true, Player(x));
    
    if (countInCol(board, "O", i) == board.length)
      return Tuple2(true, Player(o));
  }

  // if on axix, check for winner by axis
  if (countInMainAxis(board, "X") == board.length)
    return Tuple2(true, Player(x));

  
  if (countInMainAxis(board, "O") == board.length)
    return Tuple2(true, Player(o));
  
  if (countInCrossAxis(board, "X") == board.length)
    return Tuple2(true, Player(x));
  
  if (countInCrossAxis(board, "O") == board.length)
    return Tuple2(true, Player(o));

  int cc  = 0;
  board.forEach((row) {
    row.forEach((cell) {
      if (cell == "")
        cc++;
    });
  });
  

  if (cc == 0)
    return Tuple2(true, null);
  // game is not finished
  return Tuple2(false, null);

}

Tuple2 maxValue(List< List < String > > board, alpha, beta){
  var finished = terminal(board);
  if (finished.item1){
    if(finished.item2 == null)
      return Tuple2(0, null);
    return Tuple2(_player(board) == X ? 1 : -1, null);
  }

  int val = - 99999999;
  var action;
  for (var act in actions(board)){
    var newData = minValue(result(board, act.item1, act.item2), alpha, beta);

    if (newData.item1 > val){
      val = newData.item1;
      action = act;
    }

    alpha = val > alpha ? val : alpha;

    if (alpha > beta)
      break;
  }

  return Tuple2(val, action);
}


Tuple2 minValue(List< List < String > > board, alpha, beta){
var finished = terminal(board);
  if (finished.item1){
    if(finished.item2 == null)
      return Tuple2(0, null);
    return Tuple2(_player(board) == X ? 1 : -1, null);
  }

  int val = 99999999;
  var action;
  for (var act in actions(board)){
    var newData = maxValue(result(board, act.item1, act.item2), alpha, beta);

    if (newData.item1 < val){
      val = newData.item1;
      action = act;
    }

    beta = val < beta ? val: beta;

    if (alpha > beta)
      break;
  }

  return Tuple2(val, action);
}

Tuple2 alphaBeta(List< List < String > > board) {
  if (_player(board) == O)
    return maxValue(board, - 999999, 999999);
  
  return minValue(board, - 999999, 999999);
}