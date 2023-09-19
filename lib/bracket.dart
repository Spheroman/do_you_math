// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_unfocuser/flutter_unfocuser.dart';
import 'tournament.dart';
import 'models.dart';
import 'players/add_player_page.dart';
import 'players/player_page.dart';
import 'players/players_page.dart';
import 'tournaments/new_tournament_page.dart';
import 'tournaments/tournaments_page.dart';
import 'package:provider/provider.dart';
import 'package:hive_flutter/hive_flutter.dart';

Future<void> main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TournamentAdapter());
  var box = await Hive.openBox('tournaments');
  runApp(
    ChangeNotifierProvider(
      create: (context) => TournamentModel(),
      child: const MyApp(),
    ),
  );
}

class TournamentModel extends ChangeNotifier {
  late var box = Hive.box("tournaments");
  late final List<Tournament> tournaments = List.from(box.toMap().values);
  int currentTournament = -1;

  bool get selected =>
      currentTournament >= 0 && currentTournament < tournaments.length;

  Tournament get current => tournaments[currentTournament];

  bool get finished {
    if (!started) {
      return false;
    }
    for (Bracket b in current.brackets) {
      if (!b.finished) {
        return false;
      }
    }
    return true;
  }

  List<Pairing> get tables {
    List<Pairing> ret = [];
    for (Bracket b in current.brackets) {
      if (!b.finished) {
        ret += b.tables;
      }
    }
    return ret;
  }

  bool get roundFinished {
    for (Pairing p in tables) {
      if (!p.finished) {
        return false;
      }
    }
    return true;
  }

  bool get started => current.started;

  void set(Tournament t) {
    currentTournament = tournaments.indexOf(t);
    notifyListeners();
  }

  bool deleteTournament(Tournament t) {
    if (t == current) {
      currentTournament = -1;
    }
    box.deleteAt(tournaments.indexOf(t));
    return tournaments.remove(t);
  }

  void pair() {
    for (Pairing p in current.tables) {
      if (!p.finished) {
        return;
      }
    }
    current.pairings();
    notifyListeners();
  }

  void repair() {
    for (var element in current.brackets) {
      element.currentRound--;
    }
    pair();
  }

  void start() {
    current.start();
    notifyListeners();
  }

  void update() => notifyListeners();

  void add(Tournament t) {
    currentTournament = tournaments.length;
    tournaments.add(t);
    box.put(currentTournament, t);
    notifyListeners();
  }

  void drop(Player p) {
    current.dropPlayer(p);
    notifyListeners();
  }

  void addPlayer(Player player) {
    current.divisions[current.lastDivisionAddedTo].addPlayer(player);
    notifyListeners();
  }
}

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedTab = 3;

  List<Widget> pages = [
    const TablePage(),
    const PlayersPage(),
    const SetupPage(),
    const TournamentsPage(),
  ];

  // #docregion Example
  @override
  Widget build(BuildContext context) {
    // Define the children to display within the body at different breakpoints.

    return Container(
        color: Theme.of(context).colorScheme.background,
        child: AdaptiveScaffold(
          internalAnimations: false,
          // An option to override the default breakpoints used for small, medium,
          // and large.
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

          body: (_) => pages[_selectedTab],
          largeSecondaryBody: (context) => const TablePage(),

          // Override the default secondaryBody during the smallBreakpoint to be
          // empty. Must use AdaptiveScaffold.emptyBuilder to ensure it is properly
          // overridden.
          smallSecondaryBody: AdaptiveScaffold.emptyBuilder,
        ));
  }
// #enddocregion
}

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPage();
}

class _SetupPage extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentModel>(
      builder: (context, value, child) {
        List<Widget> ret = [];

        if (value.selected && value.current.setup()) {
          List<Widget> rounds = [];
          for (Bracket b in value.current.brackets) {
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
            model: value,
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
          floatingActionButton: ret.isNotEmpty && !value.current.started
              ? FloatingActionButton.extended(
                  icon: const Icon(Icons.check),
                  onPressed: () {
                    value.start();
                  },
                  label: const Text("Start Tournament"),
                )
              : null,
        );
      },
    );
  }
}

class TablePage extends StatelessWidget {
  const TablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<TournamentModel>(builder: (context, value, child) {
      if (value.selected && value.finished) {
        return Standings(
          tournament: value.current,
        );
      }
      return Unfocuser(
        minScrollDistance: 0.0,
        child: Scaffold(
          appBar: value.selected
              ? AppBar(title: Text("Round ${value.current.round} Pairings"))
              : AppBar(
                  title: const Text("Pairings"),
                ),
          body: selected(
            model: value,
            child: value.selected
                ? ListView.builder(
                    itemCount: (value.tables.length),
                    itemBuilder: (context, index) {
                      return TableCard(table: value.tables[index]);
                    },
                  )
                : null,
          ),
          floatingActionButton:
              value.selected && value.started && value.roundFinished
                  ? FloatingActionButton.extended(
                      onPressed: () => value.pair(),
                      icon: const Icon(Icons.navigate_next),
                      label: const Text("Pair next round"),
                    )
                  : null,
        ),
      );
    });
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
