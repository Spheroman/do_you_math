import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/models.dart';
import 'tournament_repository.dart';

part 'tournament_provider.g.dart';

@Riverpod(keepAlive: true)
class TournamentManager extends _$TournamentManager {
  @override
  TournamentRepository build() {
    return const TournamentRepository();
  }

  // ============ Getters (delegate to repository) ============

  bool get selected => state.selected;
  bool get started => state.started;
  bool get finished => state.finished;
  bool get roundFinished => state.roundFinished;
  Tournament? get current => state.currentTournament;
  List<Pairing> get tables => state.currentTables;
  List<Division> get divisions => state.currentDivisions;
  List<Bracket> get brackets => state.currentBrackets;

  // ============ Tournament Management ============

  void setCurrentTournament(Tournament t) {
    final idx = state.tournaments.indexWhere((tour) => tour.id == t.id);
    if (idx >= 0) {
      state = state.copyWith(currentTournamentIndex: idx);
    }
  }

  void addTournament(Tournament t) {
    state = state.copyWith(
      tournaments: [...state.tournaments, t],
      currentTournamentIndex: state.tournaments.length,
    );
  }

  /// Create a tournament with divisions in one atomic operation
  void createTournamentWithDivisions(String name, List<String> divisionNames) {
    // Create tournament
    var tournament = Tournament.create(name);

    // Create divisions
    List<Division> newDivisions = [];
    List<String> divisionIds = [];
    for (int i = 0; i < divisionNames.length; i++) {
      final division = Division.create(divisionNames[i], i)
          .copyWith(parentId: tournament.id);
      newDivisions.add(division);
      divisionIds.add(division.id);
    }

    // Update tournament with division IDs
    tournament = tournament.copyWith(divisionIds: divisionIds);

    state = state.copyWith(
      tournaments: [...state.tournaments, tournament],
      divisions: [...state.divisions, ...newDivisions],
      currentTournamentIndex: state.tournaments.length,
    );
  }

  bool deleteTournament(Tournament t) {
    final idx = state.tournaments.indexWhere((tour) => tour.id == t.id);
    if (idx < 0) return false;

    var newIndex = state.currentTournamentIndex;
    if (idx == newIndex) {
      newIndex = -1;
    } else if (idx < newIndex) {
      newIndex--;
    }

    final updated = List<Tournament>.from(state.tournaments)..removeAt(idx);
    state = state.copyWith(
      tournaments: updated,
      currentTournamentIndex: newIndex,
    );
    return true;
  }

  // ============ Division Management ============

  void ensureDivisions(int count) {
    final t = state.currentTournament;
    if (t == null) return;

    var updatedDivisions = List<Division>.from(state.divisions);
    var divisionIds = List<String>.from(t.divisionIds);

    // Add divisions if needed
    while (divisionIds.length < count) {
      final div = Division.create(
        "Division ${divisionIds.length + 1}",
        divisionIds.length,
      ).copyWith(parentId: t.id);
      updatedDivisions.add(div);
      divisionIds.add(div.id);
    }

    // Trim if too many
    divisionIds = divisionIds.sublist(0, count);

    // Update tournament
    var updatedTournaments = List<Tournament>.from(state.tournaments);
    final tIdx = updatedTournaments.indexWhere((tour) => tour.id == t.id);
    if (tIdx >= 0) {
      updatedTournaments[tIdx] = t.copyWith(divisionIds: divisionIds);
    }

    state = state.copyWith(
      divisions: updatedDivisions,
      tournaments: updatedTournaments,
    );
  }

  // ============ Player Management ============

  void addPlayer(Player player, {int? divisionIndex}) {
    final t = state.currentTournament;
    if (t == null) return;

    final idx = divisionIndex ?? t.lastDivisionAddedTo;
    if (idx >= t.divisionIds.length) return;

    final divId = t.divisionIds[idx];
    final div = state.getDivision(divId);
    if (div == null) return;

    // Add player with division reference
    final playerWithDiv = player.copyWith(divisionId: divId);

    // Insert player in alphabetical order
    var playerIds = List<String>.from(div.playerIds);
    final insertIdx = playerIds.indexWhere((pId) {
      final p = state.getPlayer(pId);
      return p != null &&
          p.name.toLowerCase().compareTo(playerWithDiv.name.toLowerCase()) > 0;
    });
    if (insertIdx == -1) {
      playerIds.add(playerWithDiv.id);
    } else {
      playerIds.insert(insertIdx, playerWithDiv.id);
    }

    // Update division
    var updatedDivisions = List<Division>.from(state.divisions);
    final divIdx = updatedDivisions.indexWhere((d) => d.id == divId);
    if (divIdx >= 0) {
      updatedDivisions[divIdx] = div.copyWith(playerIds: playerIds);
    }

    // Update tournament with player and lastDivisionAddedTo
    var updatedTournaments = List<Tournament>.from(state.tournaments);
    final tIdx = updatedTournaments.indexWhere((tour) => tour.id == t.id);
    if (tIdx >= 0) {
      updatedTournaments[tIdx] = t.copyWith(
        playerIds: [...t.playerIds, playerWithDiv.id],
        lastDivisionAddedTo: idx,
      );
    }

    state = state.copyWith(
      players: [...state.players, playerWithDiv],
      divisions: updatedDivisions,
      tournaments: updatedTournaments,
    );
  }

  void dropPlayer(Player player) {
    var updatedPlayers = state.players.map((p) {
      if (p.id == player.id) {
        return p.copyWith(dropped: true, tableStatus: 'dropped');
      }
      return p;
    }).toList();

    state = state.copyWith(players: updatedPlayers);
  }

  // ============ Match Results ============

  void setWinner(Pairing pairing, int winner) {
    // winner: 1 = playerOne wins, 2 = playerTwo wins, 3 = tie
    if (pairing.playerOneId == null) return;

    var updatedPairings = state.pairings.map((p) {
      if (p.id == pairing.id) {
        return p.copyWith(finished: true, winner: winner);
      }
      return p;
    }).toList();

    var updatedPlayers = List<Player>.from(state.players);

    final p1Idx = updatedPlayers.indexWhere((p) => p.id == pairing.playerOneId);
    final p2Idx = pairing.playerTwoId != null
        ? updatedPlayers.indexWhere((p) => p.id == pairing.playerTwoId)
        : -1;

    if (p1Idx >= 0 && p2Idx >= 0) {
      final p1 = updatedPlayers[p1Idx];
      final p2 = updatedPlayers[p2Idx];

      if (winner == 1) {
        // PlayerOne wins
        updatedPlayers[p1Idx] = p1.copyWith(winIds: [...p1.winIds, p2.id]);
        updatedPlayers[p2Idx] = p2.copyWith(lossIds: [...p2.lossIds, p1.id]);
      } else if (winner == 2) {
        // PlayerTwo wins
        updatedPlayers[p1Idx] = p1.copyWith(lossIds: [...p1.lossIds, p2.id]);
        updatedPlayers[p2Idx] = p2.copyWith(winIds: [...p2.winIds, p1.id]);
      } else if (winner == 3) {
        // Tie
        updatedPlayers[p1Idx] = p1.copyWith(tieIds: [...p1.tieIds, p2.id]);
        updatedPlayers[p2Idx] = p2.copyWith(tieIds: [...p2.tieIds, p1.id]);
      }
    }

    state = state.copyWith(
      pairings: updatedPairings,
      players: updatedPlayers,
    );
  }

  // ============ Tournament Flow ============

  void start() {
    state = state.startTournament();
  }

  void pair() {
    // Check if all tables are finished first
    for (final p in state.currentTables) {
      if (!p.finished) return;
    }
    state = state.generatePairings();
  }

  void repair() {
    // Decrement current round for all brackets and re-pair
    var updatedBrackets = state.brackets.map((b) {
      final t = state.currentTournament;
      if (t != null && t.bracketIds.contains(b.id)) {
        return b.copyWith(currentRound: b.currentRound - 1);
      }
      return b;
    }).toList();

    state = state.copyWith(brackets: updatedBrackets);
    pair();
  }

  void update() {
    // Force a rebuild by creating a new state
    state = state.copyWith();
  }
}
