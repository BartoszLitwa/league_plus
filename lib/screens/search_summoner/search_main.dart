import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/screens/search_summoner/match_list.dart';
import 'package:league_plus/screens/search_summoner/summoner_overview.dart';
import 'package:league_plus/screens/shared/main_scaffold.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class SearchSummoner extends StatefulWidget {
  @override
  _SearchSummonerState createState() => _SearchSummonerState();
}

class _SearchSummonerState extends State<SearchSummoner> {
  final String currentTitle = 'League of Legends';

  @override
  Widget build(BuildContext context) {
    final FavouriteSummoner sum = ModalRoute.of(context).settings.arguments ?? FavouriteSummoner(region: Regions.eune, summonerID: 'Synn3K');

    return MainScaffold(title: 'League of Legends',
     body: FutureBuilder<Summoner>(
       future: LeagueService.getSummonerByName(sum.region, sum.summonerID),
       builder: (context, snapshot) {
         if(snapshot.hasData && snapshot.data != null) {
          return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: <Widget>[
                  SummonerOverview(sum: sum),

                  SizedBox(height: 5),

                  MatchList(summoner: snapshot.data),
                ],
              ),
            );
         } else {
           return Center(
             child: SpinKitRing(
               color: Theme.of(context).accentColor, 
               size: 50,
              ),
           );
         }
       }
     )
    );
  }
}