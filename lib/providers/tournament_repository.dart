import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:chinese_postman/chinese_postman.dart';

import '../models/models.dart';

part 'tournament_repository.freezed.dart';

/// Centralized state container with lookup methods and business logic.
/// Replaces the mutable object references with ID-based lookups.
@freezed
class TournamentRepository with _$TournamentRepository {
  const TournamentRepository._();

  const factory TournamentRepository({
    @Default([]) List<Tournament> tournaments,
    @Default([]) List<Division> divisions,
    @Default([]) List<Player> players,
    @Default([]) List<Pairing> pairings,
    @Default([]) List<Bracket> brackets,
    @Default(-1) int currentTournamentIndex,
  }) = _TournamentRepository;

  // ============ Lookup Helpers ============

  Player? getPlayer(String id) => players.where((p) => p.id == id).firstOrNull;

  Division? getDivision(String id) =>
      divisions.where((d) => d.id == id).firstOrNull;

  Pairing? getPairing(String id) =>
      pairings.where((p) => p.id == id).firstOrNull;

  Bracket? getBracket(String id) =>
      brackets.where((b) => b.id == id).firstOrNull;

  Tournament? get currentTournament =>
      currentTournamentIndex >= 0 && currentTournamentIndex < tournaments.length
          ? tournaments[currentTournamentIndex]
          : null;

  bool get selected => currentTournament != null;

  bool get started => currentTournament?.started ?? false;

  // ============ Derived Data ============

  /// Get players for a division
  List<Player> getPlayersForDivision(String divisionId) {
    final division = getDivision(divisionId);
    if (division == null) return [];
    return division.playerIds
        .map((id) => getPlayer(id))
        .whereType<Player>()
        .toList();
  }

  /// Get active (non-dropped) players for a division
  List<Player> getActivePlayersForDivision(String divisionId) {
    return getPlayersForDivision(divisionId).where((p) => !p.dropped).toList();
  }

  /// Get divisions for current tournament
  List<Division> get currentDivisions {
    final t = currentTournament;
    if (t == null) return [];
    return t.divisionIds
        .map((id) => getDivision(id))
        .whereType<Division>()
        .toList();
  }

  /// Get brackets for current tournament
  List<Bracket> get currentBrackets {
    final t = currentTournament;
    if (t == null) return [];
    return t.bracketIds
        .map((id) => getBracket(id))
        .whereType<Bracket>()
        .toList();
  }

  /// Get tables for current tournament (active, unfinished brackets only)
  List<Pairing> get currentTables {
    List<Pairing> ret = [];
    for (final bracket in currentBrackets) {
      if (!bracket.finished) {
        ret.addAll(
            bracket.tableIds.map((id) => getPairing(id)).whereType<Pairing>());
      }
    }
    return ret;
  }

  /// Check if all tables in the current round are finished
  bool get roundFinished {
    for (final p in currentTables) {
      if (!p.finished) return false;
    }
    return currentTables.isNotEmpty;
  }

  /// Check if the entire tournament is finished
  bool get finished {
    if (!started) return false;
    for (final bracket in currentBrackets) {
      if (!bracket.finished) return false;
    }
    return true;
  }

  /// Get opponent win percent for a player (previously on Player)
  double getOpponentWinPercent(Player player) {
    if (player.opponentIds.isEmpty) return 0;
    double total = 0;
    for (final oppId in player.opponentIds) {
      final opp = getPlayer(oppId);
      if (opp != null) {
        total += opp.winPercent;
      }
    }
    return total / player.opponentIds.length;
  }

  /// Get standings for a division (sorted by score, then opponent win %)
  List<Player> getStandings(String divisionId) {
    final players = List<Player>.from(getPlayersForDivision(divisionId));
    players.sort((a, b) {
      final scoreDiff = b.score.compareTo(a.score);
      if (scoreDiff != 0) return scoreDiff;
      return getOpponentWinPercent(b).compareTo(getOpponentWinPercent(a));
    });
    return players;
  }

  /// Get player's placement string (1st, 2nd, 3rd, etc.) within their division
  /// Returns null if tournament is not finished or player has no division
  String? getPlayerPlacement(Player player) {
    if (!finished) return null;
    final divisionId = player.divisionId;
    if (divisionId == null) return null;

    final standings = getStandings(divisionId);
    final position = standings.indexWhere((p) => p.id == player.id);
    if (position < 0) return null;

    return _ordinal(position + 1);
  }

  /// Convert number to ordinal string (1st, 2nd, 3rd, etc.)
  String _ordinal(int n) {
    if (n >= 11 && n <= 13) {
      return '${n}th';
    }
    switch (n % 10) {
      case 1:
        return '${n}st';
      case 2:
        return '${n}nd';
      case 3:
        return '${n}rd';
      default:
        return '${n}th';
    }
  }

  /// Get the opponent for a player in a pairing
  Player? getOpponentInPairing(Player player, Pairing pairing) {
    if (pairing.playerOneId == player.id) {
      return pairing.playerTwoId != null
          ? getPlayer(pairing.playerTwoId!)
          : null;
    } else if (pairing.playerTwoId == player.id) {
      return pairing.playerOneId != null
          ? getPlayer(pairing.playerOneId!)
          : null;
    }
    return null;
  }

  /// Get pairing by ID or return null
  Pairing? getPlayerTable(Player player) {
    final tableStatus = player.tableStatus;
    if (tableStatus == 'bye' || tableStatus == 'dropped') {
      return null;
    }
    return getPairing(tableStatus);
  }

  // ============ Count Helpers ============

  /// Count players in a bracket (sum of all division player counts)
  int countPlayersInBracket(Bracket bracket) {
    int count = 0;
    for (final divId in bracket.divisionIds) {
      final div = getDivision(divId);
      if (div != null) {
        count += div.playerIds.length;
      }
    }
    return count;
  }
}

/// Extension to add pairing algorithm logic
extension TournamentRepositoryPairing on TournamentRepository {
  /// Generate pairings for the current round
  /// Returns the updated repository state with new pairings
  TournamentRepository generatePairings() {
    final tournament = currentTournament;
    if (tournament == null) return this;

    var repo = this;
    var updatedBrackets = List<Bracket>.from(brackets);
    var updatedPairings = List<Pairing>.from(pairings);
    var updatedPlayers = List<Player>.from(players);

    for (var i = 0; i < updatedBrackets.length; i++) {
      final bracket = updatedBrackets[i];
      if (!tournament.bracketIds.contains(bracket.id)) continue;
      if (bracket.currentRound >= bracket.rounds) {
        updatedBrackets[i] = bracket.copyWith(finished: true);
        continue;
      }

      // Reset tables for this bracket
      List<String> newTableIds = [];
      final numPlayers = repo.countPlayersInBracket(bracket);
      for (int j = 0; j < (numPlayers + 1) ~/ 2; j++) {
        final existingIdx = updatedPairings.indexWhere((p) =>
            bracket.tableIds.contains(p.id) && updatedPairings.indexOf(p) == j);
        if (existingIdx >= 0 && j < bracket.tableIds.length) {
          // Reset existing table
          final tableId = bracket.tableIds[j];
          final tableIdx = updatedPairings.indexWhere((p) => p.id == tableId);
          if (tableIdx >= 0) {
            updatedPairings[tableIdx] = updatedPairings[tableIdx].copyWith(
              playerOneId: null,
              playerTwoId: null,
              finished: false,
              winner: 0,
            );
            newTableIds.add(tableId);
          }
        } else {
          // Create a new table
          final newPairing = Pairing.create(
            number: updatedPairings.length + 1,
            name: (updatedPairings.length + 1).toString(),
          );
          updatedPairings.add(newPairing);
          newTableIds.add(newPairing.id);
        }
      }

      // Run swiss pairing algorithm for each division
      List<String> carry = [];
      var tableIt = newTableIds.iterator;

      for (final divId in bracket.divisionIds) {
        final div = repo.getDivision(divId);
        if (div == null) continue;

        // Get active players for this division
        List<Player> divPlayers = div.playerIds
            .map((id) => updatedPlayers.firstWhere((p) => p.id == id))
            .where((p) => !p.dropped)
            .toList();

        // Add carry-over players from previous division
        for (final carryId in carry) {
          final carryPlayer = updatedPlayers.firstWhere((p) => p.id == carryId);
          divPlayers.add(carryPlayer);
        }
        carry.clear();

        divPlayers.shuffle();

        // Build matching graph
        List<List<int>> list = [];
        for (int pi = 0; pi < divPlayers.length; pi++) {
          List<Player> matchables = List.of(divPlayers);
          matchables.removeAt(pi);
          for (final oppId in divPlayers[pi].opponentIds) {
            matchables.removeWhere((p) => p.id == oppId);
          }
          for (final matchable in matchables) {
            int scoreDiff = (divPlayers[pi].score + 1) * (matchable.score + 1);
            list.add([pi, divPlayers.indexOf(matchable), scoreDiff]);
          }
        }

        // Run blossom algorithm
        Blossom b = Blossom(list, true);
        List<int> matches = b.maxWeightMatching();

        Map<String, String> pairMap = {};
        for (int mi = 0; mi < matches.length; mi++) {
          if (matches[mi] != -1 &&
              !pairMap.containsKey(divPlayers[matches[mi]].id)) {
            pairMap[divPlayers[mi].id] = divPlayers[matches[mi]].id;
          }
        }

        // Sort by combined score
        var keys = pairMap.keys.toList();
        keys.sort((a, b) {
          final pa = divPlayers.firstWhere((p) => p.id == a);
          final pb = divPlayers.firstWhere((p) => p.id == b);
          final oppA = divPlayers.firstWhere((p) => p.id == pairMap[a]);
          final oppB = divPlayers.firstWhere((p) => p.id == pairMap[b]);
          return (pb.score + oppB.score).compareTo(pa.score + oppA.score);
        });

        // Assign to tables
        for (final playerId in keys) {
          if (!tableIt.moveNext()) break;
          final tableId = tableIt.current;
          final tableIdx = updatedPairings.indexWhere((p) => p.id == tableId);
          if (tableIdx >= 0) {
            updatedPairings[tableIdx] = updatedPairings[tableIdx].copyWith(
              playerOneId: playerId,
              playerTwoId: pairMap[playerId],
            );

            // Update player table status
            final p1Idx = updatedPlayers.indexWhere((p) => p.id == playerId);
            final p2Idx =
                updatedPlayers.indexWhere((p) => p.id == pairMap[playerId]);
            if (p1Idx >= 0) {
              updatedPlayers[p1Idx] =
                  updatedPlayers[p1Idx].copyWith(tableStatus: tableId);
            }
            if (p2Idx >= 0) {
              updatedPlayers[p2Idx] =
                  updatedPlayers[p2Idx].copyWith(tableStatus: tableId);
            }

            divPlayers.removeWhere(
                (p) => p.id == playerId || p.id == pairMap[playerId]);
          }
        }

        // Carry over unmatched players
        carry = divPlayers.map((p) => p.id).toList();
      }

      // Handle bye
      if (carry.isNotEmpty) {
        final byePlayer = updatedPlayers.firstWhere((p) => p.id == carry[0]);
        final byeIdx = updatedPlayers.indexOf(byePlayer);
        updatedPlayers[byeIdx] =
            byePlayer.copyWith(bye: true, tableStatus: 'bye');
      }

      updatedBrackets[i] = bracket.copyWith(
        tableIds: newTableIds,
        currentRound: bracket.currentRound + 1,
      );
    }

    // Update tournament round
    var updatedTournaments = List<Tournament>.from(tournaments);
    final tIdx = updatedTournaments.indexWhere((t) => t.id == tournament.id);
    if (tIdx >= 0) {
      updatedTournaments[tIdx] = updatedTournaments[tIdx].copyWith(
        round: tournament.round + 1,
      );
    }

    return copyWith(
      brackets: updatedBrackets,
      pairings: updatedPairings,
      players: updatedPlayers,
      tournaments: updatedTournaments,
    );
  }

  /// Setup brackets and tables for a tournament
  TournamentRepository setupTournament() {
    final tournament = currentTournament;
    if (tournament == null || tournament.started) return this;

    var updatedBrackets = <Bracket>[];
    var updatedPairings = List<Pairing>.from(pairings);
    var updatedTournaments = List<Tournament>.from(tournaments);

    // Group divisions into brackets (min 6 players per bracket)
    List<String> remainingDivIds = List.from(tournament.divisionIds);
    List<String> bracketIds = [];
    List<String> allTableIds = [];

    while (remainingDivIds.isNotEmpty) {
      var bracket = Bracket.create();
      List<String> bracketDivIds = [];
      int playerCount = 0;

      // Add divisions to bracket
      while (remainingDivIds.isNotEmpty &&
          (playerCount < 6 || bracketDivIds.isEmpty)) {
        final divId = remainingDivIds.removeAt(0);
        final div = getDivision(divId);
        if (div != null) {
          bracketDivIds.add(divId);
          playerCount += div.playerIds.length;
        }
      }

      // Create tables for this bracket
      List<String> tableIds = [];
      for (int i = 0; i < (playerCount + 1) ~/ 2; i++) {
        final pairing = Pairing.create(
          number: updatedPairings.length + 1,
          name: (updatedPairings.length + 1).toString(),
        );
        updatedPairings.add(pairing);
        tableIds.add(pairing.id);
        allTableIds.add(pairing.id);
      }

      bracket = bracket.copyWith(
        divisionIds: bracketDivIds,
        tableIds: tableIds,
        rounds: Bracket.calculateRounds(playerCount),
      );
      updatedBrackets.add(bracket);
      bracketIds.add(bracket.id);
    }

    // Merge small last bracket if needed
    if (updatedBrackets.length > 1) {
      final lastBracket = updatedBrackets.last;
      int lastCount = 0;
      for (final divId in lastBracket.divisionIds) {
        final div = getDivision(divId);
        if (div != null) lastCount += div.playerIds.length;
      }
      if (lastCount < 6) {
        updatedBrackets.removeLast();
        bracketIds.removeLast();
        if (updatedBrackets.isNotEmpty) {
          final mergeInto = updatedBrackets.last;
          updatedBrackets[updatedBrackets.length - 1] = mergeInto.copyWith(
            divisionIds: [...mergeInto.divisionIds, ...lastBracket.divisionIds],
            tableIds: [...mergeInto.tableIds, ...lastBracket.tableIds],
          );
        }
      }
    }

    // Update tournament
    final tIdx = updatedTournaments.indexWhere((t) => t.id == tournament.id);
    if (tIdx >= 0) {
      updatedTournaments[tIdx] = updatedTournaments[tIdx].copyWith(
        bracketIds: bracketIds,
        tableIds: allTableIds,
      );
    }

    return copyWith(
      brackets: [...brackets, ...updatedBrackets],
      pairings: updatedPairings,
      tournaments: updatedTournaments,
    );
  }

  /// Start the tournament
  TournamentRepository startTournament() {
    final tournament = currentTournament;
    if (tournament == null) return this;

    var repo = setupTournament();

    var updatedTournaments = List<Tournament>.from(repo.tournaments);
    final tIdx = updatedTournaments.indexWhere((t) => t.id == tournament.id);
    if (tIdx >= 0) {
      updatedTournaments[tIdx] =
          updatedTournaments[tIdx].copyWith(started: true);
    }

    repo = repo.copyWith(tournaments: updatedTournaments);
    return repo.generatePairings();
  }
}
