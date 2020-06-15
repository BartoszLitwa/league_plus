import 'package:flutter/material.dart';
import 'package:league_plus/models/champion_card_info.dart';
import 'package:league_plus/screens/profile/champion_card.dart';
import 'package:league_plus/screens/search_summoner/match_tile.dart';
import 'package:league_plus/screens/shared/loading_circle.dart';
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
  Map<String, ChampionCardInfo> _champsInfo;

  @override
  void initState() {
    super.initState();
    _cache = new Map<int, Widget>();
    _champsInfo = new Map<String, ChampionCardInfo>();
  }

  @override
  void dispose() {
    super.dispose();
    _cache.clear();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MatchListDto>(
      future: LeagueService.getSummonerMatchList(widget.summoner.region, widget.summoner.accountId),
      builder: (builder, snapshot) {
        if(snapshot.hasData) {
          final MatchListDto match = snapshot.data;

          return Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ChampionCard(champ: ChampionCardInfo(winrate: 63, kdaRatio: 4.13, championIcon: 266)), 
                      ChampionCard(champ: ChampionCardInfo(winrate: 50, kdaRatio: 2.56, championIcon: 84)), 
                      ChampionCard(champ: ChampionCardInfo(winrate: 100, kdaRatio: 3.00, championIcon: 136)), 
                    ],
                  ),
                ),

                SizedBox(height: 5,),

                Expanded(
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: match.matches.length,
                    itemBuilder: (context, index) {
                      return _getItem(index, match.matches[index]);
                    }
                  ),
                ),
              ],
            ),
          );
        } else {
          return LoadingRing();
        }
      },
    );
  }

  Widget _getItem(int index, MatchReferenceDto matchRef) {
    if(_cache[index] != null) {
      return _cache[index];
    } else {
      return FutureBuilder<MatchDto>(
        future: LeagueService.getMatchByMatchId(widget.summoner.region, matchRef.gameId.toString()),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            _cache[index] = MatchTile(
              sum: FavouriteSummoner(region: widget.summoner.region, summonerID: widget.summoner.id),
              match: snapshot.data
            );

            return _cache[index];
          } else {
            return LoadingRing();
          }
        }
      );
    }
  }
}