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
  Player ret = Player();

  @override
  Widget build(context) {
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);
    final current = tournamentManager.current;

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
                    ret.name = value;
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

    if (current.divisions.length > 1) {
      List<DropdownMenuItem<int>> items = [];
      for (Division division in current.divisions) {
        items.add(DropdownMenuItem<int>(
            value: division.number, child: Text(division.name)));
      }

      cards.add(
        UICard(
          "Division",
          DropdownButton(
            value: current.lastDivisionAddedTo,
            onChanged: (value) {
              setState(() {
                current.lastDivisionAddedTo = value!;
              });
            },
            items: items,
          ),
        ),
      );
    }

    return (Scaffold(
      appBar: AppBar(title: const Text("Add Player")),
      body: ListView(
        children: cards,
      ),
      floatingActionButton: ret.name == ""
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                tournamentManager.addPlayer(ret);
                Navigator.pop(context);
              },
              label: const Text("Save"),
              icon: const Icon(Icons.check),
            ),
    ));
  }
}
