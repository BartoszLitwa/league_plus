import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/constants/url_routes.dart';
import 'package:league_plus/services/FireStore/auth.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league_api.dart';

class MainDrawer extends StatefulWidget {
  final Color white;
  final Color dark;

  MainDrawer({this.white, this.dark});

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
              leading: Icon(Icons.account_circle, color: widget.white),
              title: Text('Profile', style: defaultStyle),
              onTap: () async {
                await DatabaseService.updateUserData(await LeagueService.getSummoner(Regions.eune, 'Synn3K'));
              },
            ),

            ListTile(
              leading: Icon(Icons.games, color: widget.white),
              title: Text('TFT', style: defaultStyle),
              onTap: () async {
                await DatabaseService.updateUserData(await LeagueService.getSummoner(Regions.eune, 'LazyTurtle345'));
              },
            ),

            ListTile(
              leading: Icon(Icons.settings, color: widget.white),
              title: Text('Settings', style: defaultStyle),
              onTap: () async {
                print('Logging in');
                EasyLoading.showInfo('Loading');
                await AuthService().signOut();
                await AuthService().signInAnon();
                EasyLoading.showSuccess('Successfuly loaded');          
              },          
            ),

            ListTile(
              leading: Icon(Icons.games, color: widget.white),
              title: Text('sign in', style: defaultStyle),
              onTap: () async {
                await AuthService().signInWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
              },
            ),

            ListTile(
              leading: Icon(Icons.games, color: widget.white),
              title: Text('register', style: defaultStyle),
              onTap: () async {
                await AuthService().registerWithEmailAndPassword('bartosz.maciej.litwa@gmail.com', 'test1234');
              },
            ),

            ListTile(
              leading: Icon(Icons.help, color: widget.white),
              title: Text('test', style: defaultStyle),
              onTap: () async {
                DatabaseService.favouriteSummoners();
              },
            ),
          ],
        ),
      ),
    );
  }
}