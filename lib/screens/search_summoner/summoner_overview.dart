import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/screens/shared/loading_circle.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/league_assets.dart';

class SummonerOverview extends StatefulWidget {
  final FavouriteSummoner sum;

  SummonerOverview({this.sum});

  @override
  _SummonerOverviewState createState() => _SummonerOverviewState();
}

class _SummonerOverviewState extends State<SummonerOverview> {
  final double fontSize = 15;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Summoner>(
      future: LeagueService.getSummonerByName(widget.sum.region, widget.sum.summonerID),
      builder: (context, snapshot) {
        if(snapshot.hasData) {
          final Summoner summoner = snapshot.data;
          final FavouriteSummoner favSummoner = FavouriteSummoner(region: summoner.region, summonerID: summoner.id);

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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Container(
                            child: Row(
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
                                        style: defaultStyle.copyWith(fontSize: fontSize),
                                      ),
                                    ),
                                  ),
                                ),

                                SizedBox(width: 20),

                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(summoner.name, style: defaultStyle.copyWith(color: Theme.of(context).accentColor, fontSize: 20)),

                                    SizedBox(height: 10,),

                                    FutureBuilder<List<League>>(
                                      future: LeagueService.getSummonersLeagues(summoner.region, summoner.id),
                                      builder: (context, snapshot) {
                                        final List<League> leagues = snapshot.data;
                                        
                                        League soloDuo;
                                        if(leagues != null && leagues.isNotEmpty)
                                          soloDuo = leagues.where((e) => e.queueType == Queues.solo).first;

                                        return Container(
                                          child: Row(
                                            children: <Widget>[
                                              CircleAvatar(
                                                backgroundImage: AssetImage(LeagueAssets.summonerLeagueToAsset(soloDuo?.tier ?? 'Unranked')),
                                                backgroundColor: Colors.transparent,
                                                radius: 10,
                                              ),
                                              SizedBox(width: 5),
                                              
                                              Text('${soloDuo?.tier ?? 'Unranked'} ${soloDuo?.rank ?? ''}', style: defaultStyle.copyWith(fontSize: fontSize)),
                                              SizedBox(width: 5,),
                                              Text('${soloDuo?.leaguePoints != null ? '|' : ''}', style: defaultStyle.copyWith(fontSize: fontSize)),
                                              SizedBox(width: 5,),
                                              Text('${soloDuo?.leaguePoints ?? ''} ${soloDuo?.leaguePoints != null ? 'LP' : ''}', style: defaultStyle.copyWith(fontSize: fontSize)),
                                            ],
                                          ),
                                        );
                                      }
                                    )
                                  ],
                                ),
                              ],
                            ),
                          ),

                          FavouriteButton(favSummoner: favSummoner,),
                        ]
                      )
                    ]
                  )
                )
              ]
            )
          );
        } else {
          return LoadingRing();
        }
      }
    );
  }
}

class FavouriteButton extends StatefulWidget {
  final FavouriteSummoner favSummoner;

  FavouriteButton({this.favSummoner});

  @override
  _FavouriteButtonState createState() => _FavouriteButtonState();
}

class _FavouriteButtonState extends State<FavouriteButton> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: DatabaseService.checkIfSummonerIsFavourite(widget.favSummoner),
      builder: (context, snapshot) {
        final bool isFavourite = snapshot.data ?? false;

        return GestureDetector(
          onTap: () async {
            await DatabaseService.updateSummoners(widget.favSummoner);
            setState(() {});
          },
          child: Icon(
            isFavourite ? Icons.star : Icons.star_border,
            color: isFavourite ? Colors.yellowAccent : Theme.of(context).accentColor,
            size: 32,
          ),
          
        );
      }
    );
  }
}