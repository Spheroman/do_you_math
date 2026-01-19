import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_unfocuser/flutter_unfocuser.dart';

import '../../models/models.dart';
import '../../providers/tournament_provider.dart';
import '../widgets/common_widgets.dart';
import 'add_player_page.dart';
import 'players_page.dart';
import 'new_tournament_page.dart';
import 'tournaments_page.dart';

/// The main application widget for this example.
class MyApp extends StatelessWidget {
  /// Creates a const main application widget.
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.green,
        brightness: Brightness.dark,
      ),
      themeMode: ThemeMode.system,
      home: const MyHomePage(),
      routes: <String, WidgetBuilder>{
        '/newTournament': (BuildContext context) => const NewTournamentPage(),
        '/addPlayer': (BuildContext context) => const AddPlayerPage(),
      },
    );
  }
}

class MyHomePage extends ConsumerStatefulWidget {
  const MyHomePage({super.key});

  @override
  ConsumerState<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends ConsumerState<MyHomePage> {
  int _selectedTab = 3;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Theme.of(context).colorScheme.surface,
        child: AdaptiveScaffold(
          internalAnimations: false,
          useDrawer: false,
          selectedIndex: _selectedTab,
          onSelectedIndexChange: (int index) {
            setState(() {
              _selectedTab = index;
            });
          },
          destinations: const <NavigationDestination>[
            NavigationDestination(
              icon: Icon(Icons.article_outlined),
              selectedIcon: Icon(Icons.article),
              label: 'Pairings',
            ),
            NavigationDestination(
              icon: Icon(Icons.person_outline),
              selectedIcon: Icon(Icons.person),
              label: 'Players',
            ),
            NavigationDestination(
              icon: Icon(Icons.settings_outlined),
              selectedIcon: Icon(Icons.settings),
              label: 'Setup',
            ),
            NavigationDestination(
              icon: Icon(Icons.list_outlined),
              selectedIcon: Icon(Icons.list),
              label: 'Tournaments',
            ),
          ],
          body: (_) => [
            const TablePage(),
            const PlayersPage(),
            const SetupPage(),
            const TournamentsPage(),
          ][_selectedTab],
          largeSecondaryBody: (context) => const TablePage(),
          smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
        ));
  }
}

class SetupPage extends ConsumerWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    List<Widget> ret = [];

    if (tournamentManager.selected && tournamentManager.current.setup()) {
      List<Widget> rounds = [];
      for (Bracket b in tournamentManager.current.brackets) {
        String name = b.divisions[0].name;
        for (int i = 1; i < b.divisions.length; i++) {
          name += " + ${b.divisions[i].name}";
        }
        rounds.add(
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                Text("${b.currentRound}/${b.rounds}",
                    style: Theme.of(context).textTheme.bodyLarge),
              ],
            ),
          ),
        );
      }
      ret.add(
        UICard(
          "Rounds",
          Column(
            mainAxisSize: MainAxisSize.min,
            children: rounds,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Setup"),
      ),
      body: selected(
        model: tournamentManager,
        child: ret.isNotEmpty
            ? ListView(
                clipBehavior: Clip.none,
                children: ret,
              )
            : const Center(
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Text(
                    "There are less than 6 players in the tournament.",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
      ),
      floatingActionButton: ret.isNotEmpty && !tournamentManager.current.started
          ? FloatingActionButton.extended(
              icon: const Icon(Icons.check),
              onPressed: () {
                tournamentManager.start();
              },
              label: const Text("Start Tournament"),
            )
          : null,
    );
  }
}

class TablePage extends ConsumerWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tournamentManagerProvider);
    final tournamentManager = ref.read(tournamentManagerProvider.notifier);

    if (tournamentManager.selected && tournamentManager.finished) {
      return Standings(
        tournament: tournamentManager.current,
      );
    }
    return Unfocuser(
      minScrollDistance: 0.0,
      child: Scaffold(
        appBar: tournamentManager.selected
            ? AppBar(
                title:
                    Text("Round ${tournamentManager.current.round} Pairings"))
            : AppBar(
                title: const Text("Pairings"),
              ),
        body: selected(
          model: tournamentManager,
          child: tournamentManager.selected
              ? ListView.builder(
                  itemCount: (tournamentManager.tables.length),
                  itemBuilder: (context, index) {
                    return TableCard(table: tournamentManager.tables[index]);
                  },
                )
              : null,
        ),
        floatingActionButton: tournamentManager.selected &&
                tournamentManager.started &&
                tournamentManager.roundFinished
            ? FloatingActionButton.extended(
                onPressed: () => tournamentManager.pair(),
                icon: const Icon(Icons.navigate_next),
                label: const Text("Pair next round"),
              )
            : null,
      ),
    );
  }
}

class Standings extends StatelessWidget {
  const Standings({super.key, required this.tournament});
  final Tournament tournament;
  @override
  Widget build(BuildContext context) {
    List<Widget> playerCards = [];
    for (Division division in tournament.divisions) {
      List<Player> players = division.standings();
      List<Widget> tmp = [];
      for (Player player in players) {
        tmp.add(
          PlayerCard(
            player: player,
            color: 1,
            standings: true,
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

    playerCards.add(
      const SizedBox(
        height: 80,
      ),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text("Standings"),
        ),
        body: ListView(children: playerCards));
  }
}
