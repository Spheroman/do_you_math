import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';
import 'tournament_page.dart';

class TournamentsPage extends ConsumerWidget {
  const TournamentsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(tournamentManagerProvider);
    final tournaments = repo.tournaments;

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
                      Text("Divisions: ${tournaments.first.divisionIds.length}")
                    ],
                  ),
                ),
                itemBuilder: (context, index) {
                  if (index >= tournaments.length) {
                    return const SizedBox(height: 10);
                  }

                  final tournament = tournaments[index];
                  final isCurrentTournament =
                      repo.currentTournament?.id == tournament.id;

                  return UICard(
                    clickable: true,
                    inkWell: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => TournamentPage(
                              tournament: tournament,
                            ),
                          ),
                        );
                      },
                    ),
                    tournament.name,
                    Column(
                      children: [
                        Text("Divisions: ${tournament.divisionIds.length}")
                      ],
                    ),
                    color: isCurrentTournament ? 1 : 0,
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
