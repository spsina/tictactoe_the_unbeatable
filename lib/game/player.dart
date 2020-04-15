enum PlayerType {
  X,
  O
}
var x = PlayerType.X;
var o = PlayerType.O;

class Player {
  PlayerType type;
  int key;
  int utilization;

  Player(this.type){
    if (type == PlayerType.X){
      key = 0;
      utilization = 1;
    }
    else{
      key = 1;
      utilization = -1;
    }
  }

  String getRepresentation() {
    if (type == PlayerType.X)
      return "X";
    return "O";
  }

}