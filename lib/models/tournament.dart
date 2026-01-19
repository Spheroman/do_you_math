import 'bracket.dart';
import 'division.dart';
import 'pairing.dart';
import 'player.dart';

class Tournament {
  List<Bracket> brackets = [];
  List<Division> divisions = [];
  List<Pairing> tables = [];
  List<Player> players = [];
  String name = "";
  int lastDivisionAddedTo = 0;
  bool started = false;
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
