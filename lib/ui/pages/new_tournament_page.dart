import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class NewTournamentPage extends ConsumerStatefulWidget {
  const NewTournamentPage({super.key});

  @override
  ConsumerState<NewTournamentPage> createState() => _NewTournamentPage();
}

class _NewTournamentPage extends ConsumerState<NewTournamentPage> {
  String tournamentName = "Tournament";
  List<String> divisionNames = ["Division 1"];
  int show = 0;

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
                    tournamentName = value;
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
                    if (divisionNames.length > 1) {
                      divisionNames.removeLast();
                    }
                  });
                },
                icon: const Icon(Icons.remove),
              ),
              Text(
                divisionNames.length.toString(),
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    divisionNames.add("Division ${divisionNames.length + 1}");
                  });
                },
                icon: const Icon(Icons.add),
              ),
            ],
          )),
    ];

    for (int i = 0; i < divisionNames.length; i++) {
      cards.add(UICard(
          "Division ${i + 1}",
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
                      divisionNames[i] = s;
                    });
                  },
                ),
              )
            ],
          )));
    }

    return Scaffold(
      appBar: AppBar(title: const Text("New Tournament")),
      body: ListView(children: cards.sublist(0, show + divisionNames.length)),
      floatingActionButton: show < 2
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                final tournamentManager =
                    ref.read(tournamentManagerProvider.notifier);
                tournamentManager.createTournamentWithDivisions(
                    tournamentName, divisionNames);
                Navigator.pop(context);
              },
              icon: const Icon(Icons.check),
              label: const Text("Continue")),
    );
  }
}
