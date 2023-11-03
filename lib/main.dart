import 'dart:io';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';
import 'bracket.dart';

void main(List<String> args) {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TournamentModel(),
      child: const MyApp(),
    ),
  );
}
