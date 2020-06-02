import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/screens/league_main/favourite_list.dart';
import 'package:league_plus/screens/league_main/search_textField.dart';
import 'package:league_plus/screens/profile/profile_card.dart';
import 'package:league_plus/screens/shared/main_scaffold.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league/classes.dart';

class LeagueMain extends StatefulWidget {
  @override
  _LeagueMainState createState() => _LeagueMainState();
}

class _LeagueMainState extends State<LeagueMain> {
  @override
  Widget build(BuildContext context) {
    return MainScaffold(title: 'League of Legends',
      body: Container(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            CircleAvatar(
                backgroundImage: AssetImage('assets/lol.png'),
                backgroundColor: Theme.of(context).primaryColor,
                radius: 40,
            ),

            SizedBox(height: 30),

            SearchTextField(),

            SizedBox(height: 30),

            FutureBuilder<FavouriteSummoner>(
              future: DatabaseService.getUserSummoner(),
              builder: (builder, snapshot) {
                if(snapshot.hasData) {
                  return ProfileCard( summoner: snapshot.data);
                }
                else {
                  return Text('No user Summoner');
                }
              }
            ),

            SizedBox(height: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Your favourites', style: defaultStyle.copyWith(fontSize: 30)),
                SizedBox(width: 10),
                Icon(Icons.star, size: 40, color: Theme.of(context).accentColor),
              ],
            ),

            SizedBox(height: 10),

            FavouriteSummonersList(),
          ],
        ),
      ),
    );
  }
}