import 'player.dart';
import 'tournament.dart';

class Division {
  List<Player> players = [];
  late Tournament parent;
  String name = "";
  int number = -1;

  Division(this.name, this.number);

  void addPlayer(Player player) {
    int idx = players.indexWhere((element) =>
        element.name.toLowerCase().compareTo(player.name.toLowerCase()) > 0);
    if (idx == -1) {
      players.add(player);
    } else {
      players.insert(idx, player);
    }
    player.division = this;
  }

  List<Player> standings() {
    List<Player> sorted = List.from(players);
    sorted.sort((a, b) => b.score.compareTo(a.score));
    List<Player> ret = [];
    while (sorted.isNotEmpty) {
      List<Player> tmp = [];
      int i = sorted.first.score;
      while (sorted.isNotEmpty && sorted.first.score == i) {
        tmp.add(sorted.removeAt(0));
      }
      tmp.sort((a, b) => b.opponentWinPercent.compareTo(a.opponentWinPercent));
      ret += tmp;
    }
    return ret;
  }

  @override
  String toString() {
    return players.toString();
  }
}
