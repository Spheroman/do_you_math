import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';

class AddPlayerPage extends ConsumerStatefulWidget {
  const AddPlayerPage({super.key});

  @override
  ConsumerState<AddPlayerPage> createState() => _AddPlayerPage();
}

class _AddPlayerPage extends ConsumerState<AddPlayerPage> {
  String playerName = "";
  int selectedDivision = 0;

  @override
  Widget build(context) {
    final repo = ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    final currentTournament = repo.currentTournament;
    if (currentTournament == null) {
      return Scaffold(
        appBar: AppBar(title: const Text("Add Player")),
        body: const Center(child: Text("No tournament selected")),
      );
    }

    // Initialize selected division from tournament
    if (selectedDivision == 0 && currentTournament.lastDivisionAddedTo != 0) {
      selectedDivision = currentTournament.lastDivisionAddedTo;
    }

    List<Widget> cards = [
      UICard(
          "Player Name",
          Center(
            child: SizedBox(
              width: 250,
              child: TextField(
                textCapitalization: TextCapitalization.words,
                autofocus: true,
                onChanged: (String value) {
                  setState(() {
                    playerName = value;
                  });
                },
                decoration: const InputDecoration(
                  labelText: "Player Name",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          )),
    ];

    final divisions = repo.currentDivisions;
    if (divisions.length > 1) {
      List<DropdownMenuItem<int>> items = [];
      for (int i = 0; i < divisions.length; i++) {
        items.add(
            DropdownMenuItem<int>(value: i, child: Text(divisions[i].name)));
      }

      cards.add(
        UICard(
          "Division",
          DropdownButton(
            value: selectedDivision,
            onChanged: (value) {
              setState(() {
                selectedDivision = value!;
              });
            },
            items: items,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text("Add Player")),
      body: ListView(
        children: cards,
      ),
      floatingActionButton: playerName.isEmpty
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                final newPlayer = Player.create(name: playerName);
                tournamentManager.addPlayer(newPlayer,
                    divisionIndex: selectedDivision);
                Navigator.pop(context);
              },
              label: const Text("Save"),
              icon: const Icon(Icons.check),
            ),
    );
  }
}
