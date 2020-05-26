import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/league_assets.dart';

class SummonerOverview extends StatelessWidget {
  final FavouriteSummoner sum;

  SummonerOverview({this.sum});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Summoner>(
      future: LeagueService.getSummonerByName(sum.region, sum.summonerID),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final Summoner summoner = snapshot.data;

          return Container(
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(LeagueService.getSummonerIcon(summoner.profileIconId)),
                            radius: 30,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Theme.of(context).primaryColor,
                                ),

                                child: Text(
                                  summoner.summonerLevel.toString(),
                                  style: defaultStyle.copyWith(fontSize: 14),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(width: 20),

                          FutureBuilder<List<League>>(
                            future: LeagueService.getSummonersLeagues(summoner.region, summoner.id),
                            builder: (context, snapshot) {
                              if(snapshot.hasData) {
                                final List<League> leagues = snapshot.data;
                                final League soloDuo = leagues.where((e) => e.queueType == Queues.solo).first;

                                return Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(summoner.name, style: defaultStyle.copyWith(color: Theme.of(context).accentColor, fontSize: 28)),

                                      SizedBox(height: 10,),

                                      Row(
                                        children: <Widget>[
                                          CircleAvatar(
                                            backgroundImage: AssetImage(LeagueAssets.summonerLeagueToAsset(soloDuo.tier)),
                                            backgroundColor: Colors.transparent,
                                            radius: 10,
                                          ),
                                          SizedBox(width: 5),
                                          
                                          Text('${soloDuo.tier ?? 'Unranked'} ${soloDuo.rank ?? ''}', style: defaultStyle),
                                          SizedBox(width: 10,),
                                          Text('|', style: defaultStyle),
                                          SizedBox(width: 10,),
                                          Text('${soloDuo.leaguePoints ?? ''} LP', style: defaultStyle),
                                        ],
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
                            }
                          ),
                        ]
                      )
                    ]
                  )
                )
              ]
            )
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
    );
  }
}