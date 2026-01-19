import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';
import 'tournament_page.dart';

class TournamentsPage extends ConsumerWidget {
  const TournamentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(tournamentManagerProvider);
    final tournaments = state.tournaments;
    final currentTournament = state.currentTournament;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Tournaments",
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
            onPressed: () {
              Navigator.pushNamed(context, '/newTournament');
            },
            icon: const Icon(Icons.add),
            label: const Text("New Tournament")),
        body: tournaments.isNotEmpty
            ? ListView.builder(
                itemCount: tournaments.length + 1,
                prototypeItem: UICard(
                  tournaments.first.name,
                  Column(
                    children: [
                      Text("Divisions: ${tournaments.first.divisions.length}")
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
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "You have no tournaments. Maybe try creating one?",
                    textAlign: TextAlign.center,
                  ),
                ),
              ));
  }
}
