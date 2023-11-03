// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

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
