import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:flutter/material.dart';
import 'package:do_you_math/tournament.dart';
import 'package:provider/provider.dart';

class NewTournamentPage extends StatefulWidget {
  const NewTournamentPage({super.key});

  @override
  State<NewTournamentPage> createState() => _NewTournamentPage();
}

class _NewTournamentPage extends State<NewTournamentPage> {
  Tournament tournament = Tournament("Tournament");

  int show = 0;
  int divisions = 1;

  @override
  Widget build(BuildContext context) {
    List<Widget> cards = [
      UICard(
          "Tournament Name",
          Center(
            child: SizedBox(
              width: 250,
              child: TextField(
                autofocus: true,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (String value) {
                  setState(() {
                    tournament.name = value;
                    if (show == 0) show += 2;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Tournament Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          )),
      UICard(
          "Number of Divisions",
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(
                onPressed: () {
                  setState(() {
                    if (divisions > 1) divisions--;
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                divisions.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    divisions++;
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          )),
    ];
    tournament.matchDivision(divisions);
    for (Division division in tournament.divisions) {
      cards.add(UICard(
          "Division ${division.number + 1}",
          Column(
            children: [
              Center(
                child: TextField(
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: "Division Name",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (String s) {
                    setState(() {
                      division.name = s;
                    });
                  },
                ),
              )
            ],
          )));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("New Tournament")),
      body: ListView(children: cards.sublist(0, show + divisions)),
      floatingActionButton: show < 2
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                var t = Provider.of<TournamentModel>(context, listen: false);
                t.add(tournament);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text("Continue")),
    );
  }
}
