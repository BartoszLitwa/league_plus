import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:league_plus/screens/search_summoner/search_main.dart';
import 'package:league_plus/screens/wrapper.dart';

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
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/searchSummoner',
      routes: {
        '/leagueMain': (context) => Wrapper(),
        '/searchSummoner': (context) => SearchSummoner(),
      },
      theme: ThemeData(
        primaryColor: Colors.grey[900],
        accentColor: Colors.white,
      ),
    );
  }
}