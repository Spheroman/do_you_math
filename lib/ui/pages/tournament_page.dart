import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class TournamentPage extends ConsumerWidget {
  const TournamentPage({super.key, required this.current});
  final Tournament current;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    List<Widget> playerCards = [];
    for (Division division in current.divisions) {
      List<Widget> tmp = [];
      for (Player player in division.players) {
        tmp.add(PlayerCard(
          player: player,
          color: 1,
          standings: tournamentManager.finished,
        ));
      }
      playerCards.add(UICard(
          division.name,
          Column(
            children: tmp,
          )));
    }
    return Scaffold(
      appBar: AppBar(title: Text(current.name)),
      floatingActionButton:
          state.tournaments.indexOf(current) != state.currentTournament
              ? FloatingActionButton.extended(
                  onPressed: () {
                    tournamentManager.set(current);
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
