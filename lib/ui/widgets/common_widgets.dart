import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../../providers/tournament_repository.dart';
import '../pages/player_page.dart';

class UICard extends StatelessWidget {
  final String name;
  final Widget child;
  final int color;
  final bool clickable;
  final InkWell? inkWell;

  const UICard(this.name, this.child,
      {super.key, this.color = 0, this.clickable = false, this.inkWell});

  @override
  Widget build(BuildContext context) {
    Widget inside = Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            child
          ]),
    );
    if (clickable) {
      inside = InkWell(
        onTap: inkWell!.onTap,
        child: inside,
      );
    }
    return Card(
        color: color == 1 ? Theme.of(context).colorScheme.onSecondary : null,
        clipBehavior: clickable ? Clip.hardEdge : null,
        child: inside);
  }
}

class PlayerCard extends ConsumerStatefulWidget {
  const PlayerCard({
    super.key,
    required this.player,
    required this.color,
    required this.standings,
  });
  final Player player;
  final int color;
  final bool standings;

  @override
  ConsumerState<PlayerCard> createState() => _PlayerCard();
}

class _PlayerCard extends ConsumerState<PlayerCard> {
  @override
  Widget build(context) {
    final repo = ref.watch(tournamentManagerProvider);
    final theme = Theme.of(context).textTheme;

    // Calculate record display
    final wins = widget.player.winIds.length;
    final losses = widget.player.lossIds.length;
    final ties = widget.player.tieIds.length;
    final displayWins = widget.player.bye ? wins + 1 : wins;
    final opponentWinPercent = repo.getOpponentWinPercent(widget.player);

    List<Widget> ret = [
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.player.name,
              style: theme.headlineSmall,
            ),
            Text(
              "$displayWins - $losses - $ties${widget.standings ? "  Opponent Win Percent: ${(opponentWinPercent * 100).toStringAsPrecision(4)}%" : ""}",
            )
          ],
        ),
      )
    ];

    // Show table info if player is at a table
    final tableStatus = widget.player.tableStatus;
    final pairing = repo.getPairing(tableStatus);
    final showTable =
        (pairing != null || widget.player.bye) && !widget.standings;

    if (showTable) {
      ret.add(const SizedBox(width: 20));
      ret.add(Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Table"),
          Text(
            widget.player.bye ? "Bye" : (pairing?.name ?? ""),
            style: theme.headlineSmall,
          )
        ],
      ));
    }

    // Show placement if tournament is finished
    final placement = repo.getPlayerPlacement(widget.player);
    if (placement != null && widget.standings) {
      ret.add(const SizedBox(width: 20));
      ret.add(Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text("Place"),
          Text(
            placement,
            style: theme.headlineSmall,
          )
        ],
      ));
    }

    return Card(
      clipBehavior: Clip.hardEdge,
      color:
          widget.color == 1 ? Theme.of(context).colorScheme.onSecondary : null,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => PlayerPage(
                playerId: widget.player.id,
              ),
            ),
          ).whenComplete(
            () => setState(() {}),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: ret,
          ),
        ),
      ),
    );
  }
}

Widget playerInfo(BuildContext context, Player player, bool right, int state) {
  final wins = player.winIds.length;
  final losses = player.lossIds.length;
  final ties = player.tieIds.length;
  final displayWins = player.bye ? wins + 1 : wins;

  var playerText = Text(
    player.name,
    style: Theme.of(context).textTheme.headlineSmall,
    textAlign: right ? TextAlign.right : TextAlign.left,
  );
  return Builder(
    builder: (context) {
      late Widget icon;
      if (state == (right ? 2 : 1)) {
        icon = const Icon(Icons.emoji_events);
      }
      if (state == 3) {
        icon = const Icon(Icons.handshake);
      }
      return InkWell(
        onTap: () {
          if (Focus.of(context).hasFocus) {
            Focus.of(context).unfocus();
          } else {
            Focus.of(context).requestFocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment:
                right ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Row(
                    mainAxisAlignment: state != 0
                        ? MainAxisAlignment.spaceBetween
                        : right
                            ? MainAxisAlignment.end
                            : MainAxisAlignment.start,
                    children: state == (right ? 2 : 1) || state == 3
                        ? right
                            ? [icon, Expanded(child: playerText)]
                            : [Expanded(child: playerText), icon]
                        : [Expanded(child: playerText)]),
              ),
              Text("$displayWins - $losses - $ties"),
            ],
          ),
        ),
      );
    },
  );
}

class TableCard extends ConsumerStatefulWidget {
  final Pairing table;
  const TableCard({super.key, required this.table});

  @override
  ConsumerState<TableCard> createState() => _TableCard();
}

class _TableCard extends ConsumerState<TableCard> {
  int playerFocus = 0;

  @override
  Widget build(BuildContext context) {
    final repo = ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    // Handle bye table
    if (widget.table.number == -1) {
      final player = repo.getPlayer(widget.table.playerOneId ?? '');
      if (player != null) {
        return PlayerCard(player: player, color: 0, standings: false);
      }
      return const SizedBox.shrink();
    }

    final playerOne = repo.getPlayer(widget.table.playerOneId ?? '');
    final playerTwo = repo.getPlayer(widget.table.playerTwoId ?? '');

    if (playerOne == null || playerTwo == null) {
      return const SizedBox.shrink();
    }

    List<Widget> ret = [];
    ret.add(
      Expanded(
        child: Focus(
          onFocusChange: (value) {
            setState(() {
              playerFocus = value ? 1 : 0;
            });
          },
          child: playerFocus != 1
              ? playerInfo(context, playerOne, false, widget.table.winner)
              : Builder(
                  builder: (BuildContext context) => TextButton.icon(
                      onPressed: () {
                        tournamentManager.setWinner(widget.table, 1);
                        Focus.of(context).unfocus();
                      },
                      label: const Text("Confirm Player 1 Win"),
                      icon: const Icon(Icons.check)),
                ),
        ),
      ),
    );

    ret.add(
      Focus(
        onFocusChange: (value) {
          setState(() {
            playerFocus = value ? 3 : 0;
          });
        },
        child: Builder(
          builder: (context) => playerFocus == 3
              ? TextButton.icon(
                  onPressed: () {
                    tournamentManager.setWinner(widget.table, 3);
                    Focus.of(context).unfocus();
                  },
                  label: const Text("Confirm Tie"),
                  icon: const Icon(Icons.check))
              : InkWell(
                  onTap: () {
                    if (Focus.of(context).hasFocus) {
                      Focus.of(context).unfocus();
                    } else {
                      Focus.of(context).requestFocus();
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const VerticalDivider(width: 0),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Table"),
                              Text(
                                widget.table.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          )),
                      const VerticalDivider(width: 0),
                    ],
                  ),
                ),
        ),
      ),
    );

    ret.add(
      Expanded(
        child: Focus(
          onFocusChange: (value) {
            setState(() {
              playerFocus = value ? 2 : 0;
            });
          },
          child: playerFocus != 2
              ? playerInfo(context, playerTwo, true, widget.table.winner)
              : Builder(
                  builder: (BuildContext context) => TextButton.icon(
                      onPressed: () {
                        tournamentManager.setWinner(widget.table, 2);
                        Focus.of(context).unfocus();
                      },
                      label: const Text("Confirm Player 2 Win"),
                      icon: const Icon(Icons.check)),
                ),
        ),
      ),
    );

    return Card(
      clipBehavior: Clip.hardEdge,
      child: IntrinsicHeight(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: ret,
        ),
      ),
    );
  }
}

Widget selected({required TournamentRepository repo, Widget? child}) {
  if (repo.selected) {
    return child!;
  }
  return const Center(
    child: Padding(
      padding: EdgeInsets.all(50),
      child: Text(
        "You have not selected a tournament.",
        textAlign: TextAlign.center,
      ),
    ),
  );
}
