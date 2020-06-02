import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:league_plus/screens/match_details/match_details_main.dart';
import 'package:league_plus/screens/search_summoner/search_main.dart';
import 'package:league_plus/screens/shared/loading_circle.dart';
import 'package:league_plus/screens/wrapper.dart';
import 'package:league_plus/services/FireStore/remote_config.dart';
import 'package:league_plus/services/league/league_api.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    // Get current version/patch to get correct and updated stuff from ddragon
    return FutureBuilder<String>(
      future: LeagueService.updateCurrentLeagueVersion(),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          return FutureBuilder<void>(
            future: ConfigRemote.setupConfigRemote(),
            builder: (context, snapshot) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                initialRoute: '/leagueMain',
                routes: {
                  '/leagueMain': (context) => Wrapper(),
                  '/searchSummoner': (context) => SearchSummoner(),
                  '/matchDetails': (context) => MatchDetails(),
                },
                theme: ThemeData(
                  primaryColor: Colors.grey[900],
                  accentColor: Colors.white,
                ),
              );
            }
        );
        } else {
          return LoadingRing();
        }
      }
    );
  }
}