import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:flutter/material.dart';
import 'package:do_you_math/tournament.dart';
import 'package:provider/provider.dart';

class PlayersPage extends StatefulWidget {
  const PlayersPage({super.key});

  @override
  State<PlayersPage> createState() => _PlayersPage();
}

class _PlayersPage extends State<PlayersPage> {
  @override
  build(context) {
    return Consumer<TournamentModel>(
      builder: (context, value, child) {
        List<Widget> playerCards = [];
        if (value.selected) {
          for (Division division in value.current.divisions) {
            List<Widget> tmp = [];
            for (Player player in division.players) {
              tmp.add(
                PlayerCard(
                  player: player,
                  color: 1,
                  standings: value.finished,
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
            floatingActionButton: value.selected && !value.started
                ? FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pushNamed(context, '/addPlayer');
                    },
                    icon: const Icon(Icons.add),
                    label: const Text("Add Player"),
                  )
                : null,
            body:
                selected(model: value, child: ListView(children: playerCards)));
      },
    );
  }
}
