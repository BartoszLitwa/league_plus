import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/screens/profile/champion_card.dart';
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
  Map<int, Widget> _cache;

  @override
  void initState() {
    super.initState();
    _cache = new Map<int, Widget>();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MatchListDto>(
      future: LeagueService.getSummonerMatchList(widget.summoner.region, widget.summoner.accountId),
      builder: (builder, snapshot) {
        if(snapshot.hasData) {
          final MatchListDto match = snapshot.data;
          print(match.totalGames);

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      //ChampionCard()
                    ],
                  ),
                ),

                SizedBox(height: 5,),

                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return _getItem(index, match.matches[index]);
                    }
                  ),
                ),
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
      },
    );
  }

  Widget _getItem(int index, MatchReferenceDto matchRef) {
    return _cache.putIfAbsent(index,
      () => FutureBuilder<MatchDto>(
        future: LeagueService.getMatchByMatchId(widget.summoner.region, matchRef.gameId.toString()),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            return MatchTile(sum: FavouriteSummoner(region: widget.summoner.region, summonerID: widget.summoner.id), match: snapshot.data);
          } else {
            return SpinKitCircle(color: Theme.of(context).accentColor, size: 50);
          }
        }
      )
    );
  }
}