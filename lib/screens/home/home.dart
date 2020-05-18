import 'package:flutter/material.dart';
import 'package:league_plus/screens/home/drawer.dart';
import 'package:league_plus/screens/home/favourite_list.dart';
import 'package:league_plus/screens/home/search_textField.dart';
import 'package:league_plus/screens/profile/profile_card.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league_classes/classes.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Color white = Colors.white;
  final Color dark = Colors.grey[900];

  String currentTitle = 'League of Legends';
  List<String> servers = ['EUNE', 'EUW', 'NA', 'KOR', 'OCE'];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Summoner>>.value(
      value: DatabaseService().summoners,
        child: Scaffold(
        backgroundColor: dark,

        drawer: MainDrawer(white: white, dark: dark),

        appBar: AppBar(
          backgroundColor: dark,
          elevation: 0,
          actionsIconTheme: IconThemeData(color: Colors.black),
          centerTitle: true,
          title: Text(currentTitle),
          actions: <Widget>[
            
          ],
        ),

        body: Container(
          padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                  backgroundImage: AssetImage('assets/lol.png'),
                  backgroundColor: dark,
                  radius: 40,
              ),

              SizedBox(height: 40),

              SearchTextField(dark: dark, white: white),

              SizedBox(height: 40),

              ProfileCard(white: white, dark: dark),

              SizedBox(height: 40),

              FavouriteSummoners(white: white, dark: dark),
            ],
          ),
        ),
      ),
    );
  }
}