import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:flutter/material.dart';
import 'package:do_you_math/tournament.dart';
import 'package:provider/provider.dart';

class PlayerPage extends StatefulWidget {
  final Player player;
  const PlayerPage({super.key, required this.player});

  @override
  State<PlayerPage> createState() => _PlayerPage();
}

class _PlayerPage extends State<PlayerPage> {
  @override
  Widget build(BuildContext context) {
    var t = Provider.of<TournamentModel>(context, listen: false);
    List<Widget> children = [];
    if (widget.player.table.number == -1) {
      children.add(
        UICard(
          "Current Opponent",
          widget.player.bye
              ? const Text("You have the bye")
              : const Text("The tournament has not started yet."),
        ),
      );
    } else if (widget.player.table.number == -2) {
      children.add(
        const UICard("Current Opponent", Text("This player has dropped.")),
      );
    } else {
      Player opponent;
      if (widget.player.table.playerOne == widget.player) {
        opponent = widget.player.table.playerTwo!;
      } else {
        opponent = widget.player.table.playerOne!;
      }
      children.add(
        UICard(
          "Current Opponent",
          PlayerCard(
            player: opponent,
            color: 1,
            standings: t.finished,
          ),
        ),
      );
    }
    List<Widget> tmp = [];
    for (Player p in widget.player.wins) {
      tmp.add(PlayerCard(player: p, color: 1, standings: false));
    }
    children.add(
      UICard(
        "Wins",
        Column(
          children: tmp,
        ),
      ),
    );
    tmp = [];
    for (Player p in widget.player.loss) {
      tmp.add(PlayerCard(player: p, color: 1, standings: false));
    }
    children.add(
      UICard(
        "Losses",
        Column(
          children: tmp,
        ),
      ),
    );
    tmp = [];
    for (Player p in widget.player.tie) {
      tmp.add(PlayerCard(player: p, color: 1, standings: false));
    }
    children.add(
      UICard(
        "Ties",
        Column(
          children: tmp,
        ),
      ),
    );
    return (Scaffold(
      appBar: AppBar(
        title: Text(widget.player.name),
        actions: [
          PopupMenuButton<Function>(
            onSelected: (value) {
              value();
            },
            itemBuilder: (context) => [
              t.started
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
                          if (value) {
                            t.drop(widget.player);
                            Navigator.pop(context, true);
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
    ));
  }
}
