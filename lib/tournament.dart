import 'package:chinese_postman/chinese_postman.dart';
import 'package:hive/hive.dart';

part 'tournament.g.dart';

@HiveType(typeId: 1)
class Tournament {
  @HiveField(0)
  List<Bracket> brackets = [];

  @HiveField(1)
  List<Division> divisions = [];

  @HiveField(2)
  List<Pairing> tables = [];

  @HiveField(3)
  List<Player> players = [];

  @HiveField(4)
  String name = "";

  @HiveField(5)
  int lastDivisionAddedTo = 0;

  @HiveField(6)
  bool started = false;

  @HiveField(7)
  int round = 0;

  Tournament(this.name);

  void matchDivision(int i) {
    while (i >= divisions.length) {
      addDivision(
          Division("Division ${divisions.length + 1}", divisions.length));
    }
    divisions = divisions.sublist(0, i);
  }

  void addDivision(Division division) {
    division.parent = this;
    divisions.add(division);
  }

  void addPlayer(Player player, int i) {
    divisions[i].addPlayer(player);
    players.add(player);
  }

  void dropPlayer(Player player) {
    player.dropped = true;
    player.table = Pairing(number: -2, name: "Dropped");
  }

  void addBracket(Bracket bracket) {
    brackets.add(bracket);
    setup();
  }

  void start() {
    started = true;
    pairings();
  }

  bool setup() {
    if (started) {
      return true;
    }
    brackets = [];
    tables = [];
    var temp = List.from(divisions);
    while (temp.isNotEmpty) {
      if (brackets.isNotEmpty && brackets.last.numPlayers() < 6) {
        bool flag = true;
        for (Division d in temp) {
          if (d.players.length < 6) {
            brackets.last.divisions.add(d);
            temp.remove(d);
            flag = false;
            break;
          }
        }
        if (flag) {
          brackets.last.divisions.add(temp.removeAt(0));
        }
      } else {
        brackets.add(Bracket());
        brackets.last.divisions.add(temp.removeAt(0));
      }
    }
    while (brackets.last.numPlayers() < 6) {
      Bracket temp = brackets.removeLast();
      if (brackets.isEmpty) {
        return false;
      }
      brackets.last.divisions.addAll(temp.divisions);
    }

    for (Bracket bracket in brackets) {
      for (int i = 1; i < bracket.numPlayers(); i += 2) {
        tables.add(Pairing(
            number: tables.length + 1, name: (tables.length + 1).toString()));
        bracket.tables.add(tables.last);
      }
      if (!bracket.setup()) {
        throw "Bracket Setup Error with $bracket";
      }
    }
    return true;
  }

  List<Pairing> pairings() {
    List<Pairing> ret = [];
    var tableIt = tables.iterator;
    for (Bracket bracket in brackets) {
      if (bracket.currentRound != bracket.rounds) {
        bracket.tables = [];
        for (int i = 1; i < bracket.numPlayers(); i += 2) {
          tableIt.moveNext();
          tableIt.current.reset();
          bracket.tables.add(tableIt.current);
        }
      }
      ret += bracket.pairings();
    }
    round++;
    return ret;
  }
}

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
    double ret = 0;
    for (Player opponent in opponents) {
      ret += opponent.winPercent;
    }
    return ret / opponents.length;
  }

  double get winPercent => wins.length / opponents.length;

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
