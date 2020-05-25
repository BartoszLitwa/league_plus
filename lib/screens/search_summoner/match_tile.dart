import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/league/league_helpers.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class MatchTile extends StatelessWidget {
  final MatchReferenceDto matchRef;
  final FavouriteSummoner sum;

  MatchTile({this.sum, this.matchRef});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<MatchDto>(
        future: LeagueService.getMatchByMatchId(sum.region, matchRef.gameId.toString()),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            final MatchDto match = snapshot.data;
            final int playerIndex = match.participantIdentities.firstWhere((e) => e.player.summonerId == sum.summonerID).participantId - 1; // To get the index
            final ParticipantDto participant = match.participants[playerIndex];
            final ParticipantStatsDto stats = participant.stats;
            final double kdaRatio = double.parse(((stats.kills + stats.assists) / stats.deaths).toStringAsFixed(2));

            return SizedBox(
              height: 105,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    color: stats.win ? Colors.blue[400] : Colors.deepOrange,
                  ),
                  child: Row(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: NetworkImage(LeagueService.getChampionIconFromChampionID(matchRef.champion)),
                            radius: 25,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.black
                                ),

                                child: Text(
                                  '${stats.champLevel}',
                                  style: defaultStyle.copyWith(fontSize: 14),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 2),

                          Container(
                            padding: EdgeInsets.only(left: 2),
                            child: Text(
                              LeagueHelper.getChampNameByID(matchRef.champion),
                              style: defaultStyle.copyWith(fontSize: 12),
                            ),
                          ),

                          SizedBox(height: 2,),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              CircleAvatar(
                                backgroundImage: NetworkImage(LeagueService.getSummonerSpellIconFromSpellID(participant.spell1Id)),
                                radius: 12,
                              ),
                              SizedBox(width: 2,),
                              CircleAvatar(
                                backgroundImage: NetworkImage(LeagueService.getSummonerSpellIconFromSpellID(participant.spell2Id)),
                                radius: 12,
                              ),
                            ],
                          ),
                        ],
                      ),
                    
                      SizedBox(width: 10,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                                backgroundImage: NetworkImage(LeagueService.getSummonerSpellIconFromSpellID(participant.spell1Id)),
                                radius: 12,
                              ),
                              SizedBox(width: 2,),
                              CircleAvatar(
                                backgroundImage: NetworkImage(LeagueService.getSummonerSpellIconFromSpellID(participant.spell2Id)),
                                radius: 12,
                              ),
                        ],
                      ),

                      SizedBox(width: 20,),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('${stats.kills} / ', style: defaultStyle.copyWith(color: Colors.greenAccent),),
                              Text('${stats.deaths} / ', style: defaultStyle.copyWith(color: Colors.white),),
                              Text('${stats.assists}', style: defaultStyle.copyWith(color: Colors.orangeAccent),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text('$kdaRatio KDA', style: defaultStyle.copyWith(color: Theme.of(context).accentColor),),
                          SizedBox(height: 10,),
                          Container(
                            child: stats.largestMultiKill >= 2 ? Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: Colors.green[900],
                              ),
                              child: Text(LeagueHelper.getMultiKillTextFromInt(stats.largestMultiKill), style: defaultStyle.copyWith(fontSize: 12, color: Theme.of(context).accentColor)),
                            ) : SizedBox(height: 0, width: 0,),
                          ),
                        ],
                      ),
                    ],
                  ),
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
      ),
    );
  }
}