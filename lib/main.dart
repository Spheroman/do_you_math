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




/*
import 'package:firebase_auth/firebase_auth.dart'
    hide PhoneAuthProvider, EmailAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';
import 'package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_adaptive_scaffold/flutter_adaptive_scaffold.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'config.dart';
import 'decorations.dart';
import 'firebase_options.dart';

final actionCodeSettings = ActionCodeSettings(
  url: 'https://flutterfire-e2e-tests.firebaseapp.com',
  handleCodeInApp: true,
  androidMinimumVersion: '1',
  androidPackageName: 'io.flutter.plugins.firebase_ui.firebase_ui_example',
  iOSBundleId: 'io.flutter.plugins.fireabaseUiExample',
);
final emailLinkProviderConfig = EmailLinkAuthProvider(
  actionCodeSettings: actionCodeSettings,
);

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  FirebaseUIAuth.configureProviders([
    EmailAuthProvider(),
    emailLinkProviderConfig,
    GoogleProvider(clientId: GOOGLE_CLIENT_ID),
  ]);

  usePathUrlStrategy();

  runApp(const App());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Container(
          color: Theme.of(context).colorScheme.primaryContainer,
          child: const Homepage()),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginPage(),
    )
  ],
  initialLocation: '/',
);

// Overrides a label for en locale
// To add localization for a custom language follow the guide here:
// https://flutter.dev/docs/development/accessibility-and-localization/internationalization#an-alternative-class-for-the-apps-localized-resources
class LabelOverrides extends DefaultLocalizations {
  const LabelOverrides();

  @override
  String get emailInputLabel => 'Enter your email';
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp.router(
        title: 'Do You Math',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        ),
        routerConfig: _router,
      ),
    );
  }
}

class AppState extends ChangeNotifier {
  void getNext() {
    notifyListeners();
  }
}

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );

    final comic = style.copyWith(fontFamily: GoogleFonts.pangolin().fontFamily);

    return Center(
        child: FutureBuilder(
      future: GoogleFonts.pendingFonts([GoogleFonts.pangolin()]),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const SizedBox();
        }
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Card(
              color: theme.colorScheme.primary,
              elevation: 4,
              child: Padding(
                  padding: const EdgeInsets.all(50),
                  child: Column(
                    children: [
                      Text(
                        "Team Do You Math",
                        style: style,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Card(
                          color: theme.colorScheme.primaryContainer,
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "1+1 = ",
                                    style: style.copyWith(
                                        color: theme
                                            .colorScheme.onPrimaryContainer),
                                  ),
                                  Text(
                                    "11",
                                    style: comic.copyWith(
                                        color: theme
                                            .colorScheme.onPrimaryContainer),
                                  )
                                ],
                              )))
                    ],
                  ))),
          Text(
            "this is a temporary website",
            style: style.copyWith(color: theme.colorScheme.onPrimaryContainer),
          ),
          if (FirebaseAuth.instance.currentUser != null)
            const Text("logged in")
          else
            const Text("not logged in"),
        ]);
      },
    ));
  }
}

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInScreen(
      actions: [
        AuthStateChangeAction<SignedIn>((context, state) {
          context.go('/');
        }),
      ],
    );
  }
}
*/