import 'package:chinese_postman/chinese_postman.dart';

import 'division.dart';
import 'pairing.dart';
import 'player.dart';

class Bracket {
  List<Division> divisions = [];
  List<Pairing> tables = [];
  Pairing byeTable = Pairing(name: "Bye", number: -1);
  int rounds = 3;
  int currentRound = 0;
  bool finished = false;

  @override
  String toString() {
    return divisions.toString();
  }

  int numPlayers() {
    int temp = 0;
    for (var division in divisions) {
      temp += division.players.length;
    }
    return temp;
  }

  bool setup() {
    int i = numPlayers() - 1 >> 3;
    rounds = 3;
    while (i > 0) {
      rounds++;
      i >>= 1;
    }
    return true;
  }

  List<Pairing> pairings() {
    if (currentRound == rounds) {
      finished = true;
      return [];
    }
    var tableIt = tables.iterator;
    tableIt.moveNext();
    List<Player> carry = [];
    for (var division in divisions) {
      List<List<int>> list = [];
      var players =
          List.of(division.players.where((element) => !element.dropped));
      players.addAll(carry);
      players.shuffle();
      for (int i = 0; i < players.length; i++) {
        List<Player> matchables = List.of(players);
        matchables.removeAt(i);
        for (Player temp in players[i].opponents) {
          matchables.remove(temp);
        }
        for (Player temp in matchables) {
          int scoreDiff = (players[i].score + 1) * (temp.score + 1);
          list.add([i, players.indexOf(temp), scoreDiff]);
        }
      }
      Blossom b = Blossom(list, true);
      List<int> matches = b.maxWeightMatching();
      Map<Player, Player> pairings = {};
      for (int i in matches) {
        if (i != -1 && !pairings.keys.contains(players[matches[i]])) {
          pairings.addAll({players[i]: players[matches[i]]});
        }
      }
      var keys = List.from(pairings.keys);
      keys.sort((a, b) => (b.score + pairings[b]!.score)
          .compareTo(a.score + pairings[a]!.score));
      for (Player a in keys) {
        tableIt.current.addPlayer(a);
        tableIt.current.addPlayer(pairings[a]!);
        players.remove(a);
        players.remove(pairings[a]);
        tableIt.moveNext();
      }
      carry = players;
    }
    if (carry.isNotEmpty) {
      carry[0].bye = true;
      byeTable.reset();
      byeTable.addPlayer(carry[0]);
      byeTable.finished = true;
      tables.add(byeTable);
    }
    currentRound++;
    return tables;
  }
}
