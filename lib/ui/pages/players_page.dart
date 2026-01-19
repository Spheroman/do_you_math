import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(tournamentManagerProvider);

    List<Widget> playerCards = [];
    if (repo.selected) {
      for (final division in repo.currentDivisions) {
        final players = repo.getPlayersForDivision(division.id);
        List<Widget> tmp = [];
        for (final player in players) {
          tmp.add(
            PlayerCard(
              player: player,
              color: 1,
              standings: repo.finished,
            ),
          );
        }
        playerCards.add(
          UICard(
            division.name,
            Column(
              children: tmp,
            ),
          ),
        );
      }
    }
    playerCards.add(
      const SizedBox(
        height: 80,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Players"),
        ),
        floatingActionButton: repo.selected && !repo.started
            ? FloatingActionButton.extended(
                onPressed: () {
                  Navigator.pushNamed(context, '/addPlayer');
                },
                icon: const Icon(Icons.add),
                label: const Text("Add Player"),
              )
            : null,
        body: selected(repo: repo, child: ListView(children: playerCards)));
  }
}
