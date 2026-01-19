import 'player.dart';

class Pairing {
  String name;
  int number;
  Map<int, Player> players = {};
  bool finished = false;
  int winner = 0;

  Pairing({required this.number, required this.name});

  void reset() {
    players = {};
    finished = false;
    winner = 0;
  }

  void setWinner(Player player) {
    if (playerOne == player) {
      winner = 1;
      playerOne!.beat(playerTwo!);
    } else {
      winner = 2;
      playerTwo!.beat(playerOne!);
    }
    finished = true;
  }

  void tie() {
    playerOne!.tied(playerTwo!);
    winner = 3;
    finished = true;
  }

  @override
  String toString() {
    if (number == -1) {
      return "${playerOne?.name} has the bye";
    }
    return "${playerOne?.name} vs ${playerTwo?.name} at Table $name";
  }

  void addPlayer(Player player) {
    if (!players.containsKey(1)) {
      players.addAll({1: player});
      player.table = this;
    } else if (!players.containsKey(2) && number != -1) {
      players.addAll({2: player});
      player.table = this;
    }
  }

  Player? get playerOne => players[1];
  Player? get playerTwo => players[2];
}
