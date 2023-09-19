import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:flutter/material.dart';
import 'package:do_you_math/tournament.dart';
import 'package:provider/provider.dart';

class AddPlayerPage extends StatefulWidget {
  const AddPlayerPage({super.key});

  @override
  State<AddPlayerPage> createState() => _AddPlayerPage();
}

class _AddPlayerPage extends State<AddPlayerPage> {
  Player ret = Player();
  @override
  build(context) {
    var t = Provider.of<TournamentModel>(context);
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

    if (t.current.divisions.length > 1) {
      List<DropdownMenuItem<int>> items = [];
      for (Division division in t.current.divisions) {
        items.add(DropdownMenuItem<int>(
            value: division.number, child: Text(division.name)));
      }

      cards.add(
        UICard(
          "Division",
          DropdownButton(
            value: t.current.lastDivisionAddedTo,
            onChanged: (value) {
              setState(() {
                t.current.lastDivisionAddedTo = value!;
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
                t.addPlayer(ret);
                Navigator.pop(context);
              },
              label: const Text("Save"),
              icon: const Icon(Icons.check),
            ),
    ));
  }
}
