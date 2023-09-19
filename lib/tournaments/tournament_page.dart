import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:flutter/material.dart';
import 'package:do_you_math/tournament.dart';
import 'package:provider/provider.dart';

class TournamentPage extends StatelessWidget {
  const TournamentPage({super.key, required this.current});
  final Tournament current;

  @override
  Widget build(BuildContext context) {
    int currentTournament =
        Provider.of<TournamentModel>(context, listen: false).currentTournament;
    List<Tournament> tournaments =
        Provider.of<TournamentModel>(context, listen: false).tournaments;
    List<Widget> playerCards = [];
    for (Division division in current.divisions) {
      List<Widget> tmp = [];
      for (Player player in division.players) {
        tmp.add(PlayerCard(
          player: player,
          color: 1,
          standings:
              Provider.of<TournamentModel>(context, listen: false).finished,
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
      floatingActionButton: tournaments.indexOf(current) != currentTournament
          ? Consumer<TournamentModel>(
              builder: (context, value, child) {
                return FloatingActionButton.extended(
                  onPressed: () {
                    value.set(current);
                    Navigator.pop(context);
                  },
                  label: const Text("Use this Tournament"),
                  icon: const Icon(Icons.check),
                );
              },
            )
          : null,
      body: ListView(children: playerCards),
    );
  }
}
