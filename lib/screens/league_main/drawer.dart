import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/FireStore/auth.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/classes.dart';

class MainDrawer extends StatefulWidget {
  @override
  _MainDrawerState createState() => _MainDrawerState();
}

class _MainDrawerState extends State<MainDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      elevation: 10,
      child: Container(
        color: Colors.grey[800],
        child: ListView(
          padding: EdgeInsets.all(10),
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                
              ),
              child: Text(
                'League Plus',
                style: defaultStyle.copyWith(fontSize: 30),
              ),
            ),

            ListTile(
              leading: Icon(Icons.account_circle, color: Theme.of(context).accentColor),
              title: Text('Profile', style: defaultStyle),
              onTap: () async {
                var sum = await LeagueService.getSummonerByName(Regions.eune, 'Synn3K');
                await DatabaseService.updateSummoners(FavouriteSummoner(summonerID: sum.id, region: Regions.eune));
              },
            ),

            ListTile(
              leading: Icon(Icons.games, color: Theme.of(context).accentColor),
              title: Text('TFT', style: defaultStyle),
              onTap: () async {
                var sum = await LeagueService.getSummonerByName(Regions.eune, 'LazyTurtle345');
                await DatabaseService.updateSummoners(FavouriteSummoner(summonerID: sum.id, region: Regions.eune));
              },
            ),

            ListTile(
              leading: Icon(Icons.settings, color: Theme.of(context).accentColor),
              title: Text('Settings', style: defaultStyle),
              onTap: () async {
                print('Logging in');
                await AuthService().signOut();
                await AuthService().signInAnon();
              },          
            ),

            ListTile(
              leading: Icon(Icons.games, color: Theme.of(context).accentColor),
              title: Text('sign in', style: defaultStyle),
              onTap: () async {
                await AuthService().signInWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
              },
            ),

            ListTile(
              leading: Icon(Icons.games, color: Theme.of(context).accentColor),
              title: Text('register', style: defaultStyle),
              onTap: () async {
                await AuthService().registerWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
              },
            ),

            ListTile(
              leading: Icon(Icons.help, color: Theme.of(context).accentColor),
              title: Text('test', style: defaultStyle),
              onTap: () async {
              },
            ),
          ],
        ),
      ),
    );
  }
}