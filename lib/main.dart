import 'package:flutter/material.dart';
import 'package:league_plus/screens/search_summoner/search_home.dart';
import 'package:league_plus/screens/wrapper.dart';

void main() => runApp(App());

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (context) => Wrapper(),
        '/searchSummoner': (context) => SearchSummoner(),
      },
    );
  }
}