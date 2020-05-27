import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_assets.dart';

class FavourtieTile extends StatelessWidget {
  final Summoner sum;

  FavourtieTile({this.sum});

  @override 
  Widget build(BuildContext context) {
    return FutureBuilder<League>(
      future: LeagueService.getSummonerSoloLeague(sum.region, sum.id),
      builder: (context, AsyncSnapshot<League> snapshot) {
        if(snapshot.hasData) {
          final double _winrate = double.parse(((snapshot.data.wins / (snapshot.data.wins + snapshot.data.losses)) * 100).toStringAsFixed(1));
          final Color _winrateColor = _winrate > 70 ? Colors.green[600] : _winrate > 55 ? Colors.orange : _winrate > 35 ? Colors.grey : Colors.redAccent;

          return FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, '/searchSummoner', arguments: FavouriteSummoner(region: sum.region, summonerID: sum.name));
            },
            child: Padding(
              padding: EdgeInsets.only(bottom: 10),
              child: Card(
                elevation: 1,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(LeagueService.getSummonerIcon(sum.profileIconId)),
                    radius: 25,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Colors.black
                        ),

                        child: Text(
                          '${sum.summonerLevel}',
                          style: defaultStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(sum.name, style: defaultStyle.copyWith(color: Colors.black, fontSize: 18)),
                      FutureBuilder<Champion>(
                        future: LeagueService.getSummonerMostMasteryChampion(sum.region, sum.id),
                        builder: (context, snapshot) {
                          if(snapshot.hasData) {
                            return CircleAvatar(
                              backgroundImage: AssetImage(LeagueAssets.getChampionIconFromChampionID(snapshot.data.championId)),
                              backgroundColor: Colors.transparent,
                              radius: 16,
                            );
                          }
                          else
                            return Text('');
                        }
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(LeagueAssets.summonerLeagueToAsset(snapshot.data.tier)),
                            backgroundColor: Colors.transparent,
                            radius: 10,
                          ),
                          SizedBox(width: 5),
                          
                          Text('${snapshot.data.tier ?? 'Unranked'} ${snapshot.data.rank ?? ''}', style: smallDarkStyle),
                          SizedBox(width: 10,),
                          Text('|', style: smallDarkStyle),
                          SizedBox(width: 10,),
                          Text('${snapshot.data.leaguePoints ?? ''} LP', style: smallDarkStyle),
                        ],
                      ),
                      
                      Text('$_winrate%', style: defaultStyle.copyWith(color: _winrateColor, fontSize: 14)),
                    ],
                  ),
                ),
              ),
            ),
          );
        }
        else
          return Text('');
      }
    );
  }
}