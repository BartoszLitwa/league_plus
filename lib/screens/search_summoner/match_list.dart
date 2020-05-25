import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/screens/search_summoner/match_tile.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class MatchList extends StatefulWidget {
  final Summoner summoner;

  MatchList({this.summoner});

  @override
  _MatchListState createState() => _MatchListState();
}

class _MatchListState extends State<MatchList> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MatchListDto>(
      future: LeagueService.getSummonerMatchList(widget.summoner.region, widget.summoner.accountId),
      builder: (builder, snapshot) {
        if(snapshot.hasData) {
          return Expanded(
            child: ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: 5,
              itemBuilder: (context, index) {
                return MatchTile(sum: FavouriteSummoner(region: widget.summoner.region, summonerID: widget.summoner.id), matchRef: snapshot.data.matches[index]);
              }
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
      },
    );
  }
}