import 'package:do_you_math/bracket.dart';
import 'package:do_you_math/models.dart';
import 'package:do_you_math/tournaments/tournament_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TournamentsPage extends StatefulWidget {
  const TournamentsPage({super.key});

  @override
  State<TournamentsPage> createState() => _TournamentsPage();
}

class _TournamentsPage extends State<TournamentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tournaments",
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/newTournament')
                  .whenComplete(() => setState(() {}));
            },
            icon: const Icon(Icons.add),
            label: const Text("New Tournament")),
        body: Consumer<TournamentModel>(
          builder: (context, value, child) {
            var tournaments = value.tournaments;
            var currentTournament = value.currentTournament;
            return tournaments.isNotEmpty
                ? ListView.builder(
                    itemCount: tournaments.length + 1,
                    prototypeItem: UICard(
                      tournaments.first.name,
                      Column(
                        children: [
                          Text(
                              "Divisions: ${tournaments.first.divisions.length}")
                        ],
                      ),
                    ),
                    itemBuilder: (context, index) {
                      return index < tournaments.length
                          ? UICard(
                              clickable: true,
                              inkWell: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          TournamentPage(
                                        current: tournaments[index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                              tournaments[index].name,
                              Column(
                                children: [
                                  Text(
                                      "Divisions: ${tournaments[index].divisions.length}")
                                ],
                              ),
                              color: index == currentTournament ? 1 : 0,
                            )
                          : const SizedBox(
                              height: 10,
                            );
                    },
                  )
                : child!;
          },
          child: const Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: Text(
                "You have no tournaments. Maybe try creating one?",
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ));
  }
}
