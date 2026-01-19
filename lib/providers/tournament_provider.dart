import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/models.dart';

part 'tournament_provider.g.dart';

@Riverpod(keepAlive: true)
class TournamentManager extends _$TournamentManager {
  @override
  TournamentState build() {
    return TournamentState();
  }

  bool get selected =>
      state.currentTournament >= 0 &&
      state.currentTournament < state.tournaments.length;

  Tournament get current => state.tournaments[state.currentTournament];

  bool get finished {
    if (!started) {
      return false;
    }
    for (Bracket b in current.brackets) {
      if (!b.finished) {
        return false;
      }
    }
    return true;
  }

  List<Pairing> get tables {
    List<Pairing> ret = [];
    for (Bracket b in current.brackets) {
      if (!b.finished) {
        ret += b.tables;
      }
    }
    return ret;
  }

  bool get roundFinished {
    for (Pairing p in tables) {
      if (!p.finished) {
        return false;
      }
    }
    return true;
  }

  bool get started => current.started;

  void set(Tournament t) {
    state = state.copyWith(
      currentTournament: state.tournaments.indexOf(t),
    );
  }

  bool deleteTournament(Tournament t) {
    if (t == current) {
      state = state.copyWith(currentTournament: -1);
    }
    final updated = List<Tournament>.from(state.tournaments)..remove(t);
    state = state.copyWith(tournaments: updated);
    return true;
  }

  void pair() {
    for (Pairing p in current.tables) {
      if (!p.finished) {
        return;
      }
    }
    current.pairings();
    ref.notifyListeners();
  }

  void repair() {
    for (var element in current.brackets) {
      element.currentRound--;
    }
    pair();
  }

  void start() {
    current.start();
    ref.notifyListeners();
  }

  void update() => ref.notifyListeners();

  void add(Tournament t) {
    final updated = List<Tournament>.from(state.tournaments)..add(t);
    state = state.copyWith(
      currentTournament: updated.length - 1,
      tournaments: updated,
    );
  }

  void drop(Player p) {
    current.dropPlayer(p);
    ref.notifyListeners();
  }

  void addPlayer(Player player) {
    current.divisions[current.lastDivisionAddedTo].addPlayer(player);
    ref.notifyListeners();
  }
}

class TournamentState {
  final List<Tournament> tournaments;
  final int currentTournament;

  TournamentState({
    this.tournaments = const [],
    this.currentTournament = -1,
  });

  TournamentState copyWith({
    List<Tournament>? tournaments,
    int? currentTournament,
  }) {
    return TournamentState(
      tournaments: tournaments ?? this.tournaments,
      currentTournament: currentTournament ?? this.currentTournament,
    );
  }
}
