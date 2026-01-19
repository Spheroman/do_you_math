import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class PlayersPage extends ConsumerWidget {
  const PlayersPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    List<Widget> playerCards = [];
    if (tournamentManager.selected) {
      for (Division division in tournamentManager.current.divisions) {
        List<Widget> tmp = [];
        for (Player player in division.players) {
          tmp.add(
            PlayerCard(
              player: player,
              color: 1,
              standings: tournamentManager.finished,
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
        floatingActionButton:
            tournamentManager.selected && !tournamentManager.started
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addPlayer');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Player"),
                  )
                : null,
        body: selected(
            model: tournamentManager, child: ListView(children: playerCards)));
  }
}
