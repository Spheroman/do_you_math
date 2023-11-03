import 'dart:math';
import 'tournament.dart';
import 'package:do_you_math/bracket.dart';
import 'package:flutter/material.dart';
import 'players/player_page.dart';
import 'package:provider/provider.dart';

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

class PlayerCard extends StatefulWidget {
  const PlayerCard(
      {super.key,
      required this.player,
      required this.color,
      required this.standings});
  final Player player;
  final int color;
  final bool standings;

  @override
  State<PlayerCard> createState() => _PlayerCard();
}

class _PlayerCard extends State<PlayerCard> {
  @override
  Widget build(context) {
    final theme = Theme.of(context).textTheme;
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
              "${widget.player.bye ? widget.player.wins.length + 1 : widget.player.wins.length} - ${widget.player.loss.length} - ${widget.player.tie.length}${widget.standings ? "  Opponent Win Percent: ${(widget.player.opponentWinPercent * 100).toStringAsPrecision(4)}%" : ""}",
            )
          ],
        ),
      )
    ];

    if ((widget.player.table.number != -1 || widget.player.bye) &&
        !widget.standings) {
      ret.add(const SizedBox(
        width: 20,
      ));
      ret.add(Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const Text(
            "Table",
          ),
          Text(
            widget.player.table.name,
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
                player: widget.player,
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
              Text(
                  "${player.bye ? player.wins.length + 1 : player.wins.length} - ${player.loss.length} - ${player.tie.length}"),
            ],
          ),
        ),
      );
    },
  );
}

class TableCard extends StatefulWidget {
  final Pairing table;
  const TableCard({super.key, required this.table});

  @override
  State<TableCard> createState() => _TableCard();
}

class _TableCard extends State<TableCard> {
  int playerFocus = 0;
  @override
  Widget build(BuildContext context) {
    if (widget.table.number == -1) {
      return PlayerCard(
          player: widget.table.playerOne!, color: 0, standings: false);
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
              ? playerInfo(
                  context, widget.table.playerOne!, false, widget.table.winner)
              : Builder(
                  builder: (BuildContext context) => TextButton.icon(
                      onPressed: () {
                        widget.table.setWinner(widget.table.playerOne!);
                        Focus.of(context).unfocus();
                        Provider.of<TournamentModel>(context, listen: false)
                            .update();
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
                    widget.table.tie();
                    Focus.of(context).unfocus();
                    Provider.of<TournamentModel>(context, listen: false)
                        .update();
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
                      const VerticalDivider(
                        width: 0,
                      ),
                      Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Table",
                              ),
                              Text(
                                widget.table.name,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                            ],
                          )),
                      const VerticalDivider(
                        width: 0,
                      ),
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
              ? playerInfo(
                  context, widget.table.playerTwo!, true, widget.table.winner)
              : Builder(
                  builder: (BuildContext context) => TextButton.icon(
                      onPressed: () {
                        widget.table.setWinner(widget.table.playerTwo!);
                        Focus.of(context).unfocus();
                        Provider.of<TournamentModel>(context, listen: false)
                            .update();
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

Widget selected({required TournamentModel model, Widget? child}) {
  if (model.selected) {
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
