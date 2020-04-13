enum PlayerType {
  X,
  O
}

class Player {
  PlayerType type;

  Player(this.type);

  String getRepresentation() {
    if (type == PlayerType.X)
      return "X";
    return "O";
  }

}