import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class TournamentPage extends ConsumerWidget {
  const TournamentPage({super.key, required this.tournament});
  final Tournament tournament;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    List<Widget> playerCards = [];

    // Get divisions for this tournament
    for (final divId in tournament.divisionIds) {
      final division = repo.getDivision(divId);
      if (division == null) continue;

      final players = repo.getPlayersForDivision(divId);
      List<Widget> tmp = [];
      for (final player in players) {
        tmp.add(PlayerCard(
          player: player,
          color: 1,
          standings: repo.finished,
        ));
      }
      playerCards.add(UICard(
          division.name,
          Column(
            children: tmp,
          )));
    }

    // Check if this tournament is current
    final isCurrentTournament = repo.currentTournament?.id == tournament.id;

    return Scaffold(
      appBar: AppBar(title: Text(tournament.name)),
      floatingActionButton: !isCurrentTournament
          ? FloatingActionButton.extended(
              onPressed: () {
                tournamentManager.setCurrentTournament(tournament);
                Navigator.pop(context);
              },
              label: const Text("Use this Tournament"),
              icon: const Icon(Icons.check),
            )
          : null,
      body: ListView(children: playerCards),
    );
  }
}
