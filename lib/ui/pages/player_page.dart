import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class PlayerPage extends ConsumerStatefulWidget {
  final String playerId;
  const PlayerPage({super.key, required this.playerId});

  @override
  ConsumerState<PlayerPage> createState() => _PlayerPage();
}

class _PlayerPage extends ConsumerState<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    final player = repo.getPlayer(widget.playerId);
    if (player == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Player Not Found")),
        body: const Center(child: Text("This player no longer exists.")),
      );
    }

    List<Widget> children = [];

    // Current opponent section
    final tableStatus = player.tableStatus;
    if (tableStatus == 'bye') {
      children.add(
        UICard(
          "Current Opponent",
          player.bye
              ? const Text("You have the bye")
              : const Text("The tournament has not started yet."),
        ),
      );
    } else if (tableStatus == 'dropped') {
      children.add(
        const UICard("Current Opponent", Text("This player has dropped.")),
      );
    } else {
      final pairing = repo.getPairing(tableStatus);
      if (pairing != null) {
        final opponent = repo.getOpponentInPairing(player, pairing);
        if (opponent != null) {
          children.add(
            UICard(
              "Current Opponent",
              PlayerCard(
                player: opponent,
                color: 1,
                standings: tournamentManager.finished,
              ),
            ),
          );
        }
      } else {
        children.add(
          const UICard(
            "Current Opponent",
            Text("The tournament has not started yet."),
          ),
        );
      }
    }

    // Wins section
    List<Widget> winWidgets = [];
    for (final oppId in player.winIds) {
      final opp = repo.getPlayer(oppId);
      if (opp != null) {
        winWidgets.add(PlayerCard(player: opp, color: 1, standings: false));
      }
    }
    children.add(
      UICard(
        "Wins",
        Column(children: winWidgets),
      ),
    );

    // Losses section
    List<Widget> lossWidgets = [];
    for (final oppId in player.lossIds) {
      final opp = repo.getPlayer(oppId);
      if (opp != null) {
        lossWidgets.add(PlayerCard(player: opp, color: 1, standings: false));
      }
    }
    children.add(
      UICard(
        "Losses",
        Column(children: lossWidgets),
      ),
    );

    // Ties section
    List<Widget> tieWidgets = [];
    for (final oppId in player.tieIds) {
      final opp = repo.getPlayer(oppId);
      if (opp != null) {
        tieWidgets.add(PlayerCard(player: opp, color: 1, standings: false));
      }
    }
    children.add(
      UICard(
        "Ties",
        Column(children: tieWidgets),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(player.name),
        actions: [
          PopupMenuButton<Function>(
            onSelected: (value) {
              value();
            },
            itemBuilder: (context) => [
              tournamentManager.started
                  ? PopupMenuItem<Function>(
                      value: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text("Drop Player"),
                            content: const Text(
                                "Are you sure you want to drop this player? \n\nThis action cannot be reversed."),
                            actions: <Widget>[
                              TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text("Cancel")),
                              TextButton(
                                onPressed: () => Navigator.pop(context, true),
                                child: const Text("OK"),
                              )
                            ],
                          ),
                        ).then((value) {
                          if (value == true) {
                            tournamentManager.dropPlayer(player);
                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          }
                        });
                      },
                      child: const Text(
                        "Drop Player",
                      ),
                    )
                  : PopupMenuItem<Function>(
                      value: () {},
                      child: const Text("Remove Player"),
                    ),
            ],
          )
        ],
      ),
      body: ListView(children: children),
    );
  }
}
