import 'package:tictactoe/game/player.dart';
import 'package:tuple/tuple.dart';
var X = "X";
var O = "O";
var inf = 9999999999999;

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

bool targetWin(List< List < String > >board, String target){

  // winner by row
  for (var i = 0 ; i < board.length; i++){
    if (countInRow(board, target, i) == board.length)
      return true;
  }
  
  for (var i = 0 ; i < board.length; i++){
    if (countInCol(board, target, i) == board.length)
      return true;
  }

  // if on axix, check for winner by axis
  if (countInMainAxis(board, target) == board.length)
    return true;
  
  if (countInCrossAxis(board, target) == board.length)
    return true;
  
  return false;
}

Tuple2<bool, Player> gameFinished(List< List < String > > board){
  
  if (targetWin(board, "X"))
    return Tuple2(true, Player(x));

  if (targetWin(board, "O"))
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

Tuple2<bool, Player> terminal(List< List < String > > actual_board){
  // check to see if game is finished,
  // either we have a winner or, board is full

  // check if the last played move, makes a win
  int wincount = 4;
  int pad = actual_board.length - wincount;

  if (pad <= 0)
    return gameFinished(actual_board);

  for (var i = 0; i <= pad; i ++){
    for (var j = 0; j <= pad; j ++){
      List< List < String > > board;
      board = List<List<String>>.generate(wincount, (k) {
          return List<String>.generate(wincount, (l) {
            return actual_board[k + i][l + j];
        }); 
      });
      var gf = gameFinished(board);

      if (gf.item1)
        return gf;
    }
  }

  return Tuple2(false, null);

}

int utility(List< List < String > > board){
  var pl = _player(board); 
  var opp = pl == X ? O : X;

  int u = 0;

  for (var i = 0;i<board.length; i++){
    int countr = countInRow(board, opp, i);
    int countc = countInCol(board, opp, i);

    if (countr == 0)
      u++;
    
    if (countc == 0)
      u++;
  }

  int ma = countInMainAxis(board, opp);
  int ca = countInCrossAxis(board, opp);

  if (ma == 0)
    u++;
  
  if (ca == 0)
    u++;
  
  if (pl == X)
    return u;
  return -u;
}

Tuple2 maxValue(List< List < String > > board, alpha, beta, d){
  var finished = terminal(board);
  if (finished.item1){
    if(finished.item2 == null)
      return Tuple2(0, null);
    return Tuple2(_player(board) == X ? inf : - inf, null);
  }

  if (d == 0)
    return Tuple2(utility(board), null);

  int val = - inf;
  var action;
  for (var act in actions(board)){
    var newData = minValue(result(board, act.item1, act.item2), alpha, beta, d-1);

    if (newData.item1 >= val){
      val = newData.item1;
      action = act;
    }

    alpha = val > alpha ? val : alpha;

    if (alpha > beta)
      break;
  }

  return Tuple2(val, action);
}


Tuple2 minValue(List< List < String > > board, alpha, beta, d){
  var finished = terminal(board);
  
  if (finished.item1){
    if(finished.item2 == null)
      return Tuple2(0, null);
    return Tuple2(_player(board) == X ?  inf : - inf, null);
  }

  if (d == 0)
    return Tuple2(utility(board), null); 
   
  int val = inf;
  var action;
  for (var act in actions(board)){
    var newData = maxValue(result(board, act.item1, act.item2), alpha, beta, d - 1);

    if (newData.item1 <= val){
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
  int d = board.length == 3 ? inf : 1;
  return maxValue(board, - inf, inf, d);
}