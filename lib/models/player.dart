import 'pairing.dart';
import 'division.dart';

class Player {
  String name = "";
  late Division division;
  Pairing table = Pairing(number: -1, name: "Bye");
  List<Player> wins = [], loss = [], tie = [];
  bool bye = false;
  bool dropped = false;

  Player({this.name = ""});

  int get score {
    return 3 * wins.length + 1 * tie.length + (bye ? 3 : 0);
  }

  List<Player> get opponents {
    return wins + loss + tie;
  }

  double get opponentWinPercent {
    if (opponents.isEmpty) return 0;
    double ret = 0;
    for (Player opponent in opponents) {
      ret += opponent.winPercent;
    }
    return ret / opponents.length;
  }

  double get winPercent =>
      opponents.isEmpty ? 0 : wins.length / opponents.length;

  @override
  String toString() => name;

  void beat(Player player) {
    loss.remove(player);
    tie.remove(player);
    wins.remove(player);
    wins.add(player);
    player.wins.remove(this);
    player.tie.remove(this);
    player.loss.remove(this);
    player.loss.add(this);
  }

  void tied(Player player) {
    tie.remove(this);
    tie.add(player);
    loss.remove(player);
    wins.remove(player);
    player.tie.remove(this);
    player.tie.add(this);
    player.wins.remove(this);
    player.loss.remove(this);
  }
}
