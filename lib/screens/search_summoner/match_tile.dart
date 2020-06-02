import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/models/match_details_info.dart';
import 'package:league_plus/screens/search_summoner/item_icon.dart';
import 'package:league_plus/screens/search_summoner/match_participants.dart';
import 'package:league_plus/services/league/league_assets.dart';
import 'package:league_plus/services/league/league_helpers.dart';
import 'package:league_plus/services/league/classes.dart';

class MatchTile extends StatelessWidget {
  final FavouriteSummoner sum;
  final MatchDto match;

  MatchTile({this.sum, this.match});

  @override
  Widget build(BuildContext context) {
    final int playerIndex = match.participantIdentities.firstWhere((e) => e.player.summonerId == sum.summonerID).participantId - 1; // To get the index
    final ParticipantDto participant = match.participants[playerIndex];
    final ParticipantStatsDto stats = participant.stats;
    double kdaRatio = double.parse(((stats.kills + stats.assists) / stats.deaths).toStringAsFixed(2));
    kdaRatio = (kdaRatio == double.nan || kdaRatio == double.negativeInfinity || kdaRatio == double.infinity) ? 'Perfect' : kdaRatio;

    return GestureDetector(
      onTap: () async {
        Navigator.pushNamed(context, '/matchDetails', arguments: MatchDetailsInfo(
          sum: sum,
          match: match,
          playerIndex: playerIndex,
          kdaRatio: kdaRatio,
        ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          height: 105,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(15)),
                color: stats.win ? Colors.blue[400] : Colors.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('${match.gameMode} mode', style: defaultStyle.copyWith(fontSize: 12)),
                            Text('${DateTime.fromMillisecondsSinceEpoch(match.gameCreation + match.gameDuration)}', style: defaultStyle.copyWith(fontSize: 12)),

                            CircleAvatar(
                              backgroundColor: Colors.transparent,
                              backgroundImage: AssetImage(LeagueAssets.getChampionIconFromChampionID(participant.championId)),
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

                            Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                CircleAvatar(
                                  backgroundImage: AssetImage(LeagueAssets.getRuneIconFromRuneID(stats.perk0)),
                                  backgroundColor: Colors.black,
                                  radius: 12,
                                ),
                                SizedBox(width: 2,),
                                CircleAvatar(
                                  backgroundImage: AssetImage(LeagueAssets.getRuneIconFromRuneID(stats.perkSubStyle)),
                                  backgroundColor: Colors.black,
                                  radius: 10,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 2),

                      Container(
                        padding: EdgeInsets.only(left: 5),
                        child: Text(
                          LeagueHelper.getChampNameByID(participant.championId),
                          style: defaultStyle.copyWith(fontSize: 12),
                        ),
                      ),

                      SizedBox(height: 2,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          CircleAvatar(
                            backgroundImage: AssetImage(LeagueAssets.getSummonerSpellIconFromSpellID(participant.spell1Id)),
                            radius: 12,
                          ),
                          SizedBox(width: 2,),
                          CircleAvatar(
                            backgroundImage: AssetImage(LeagueAssets.getSummonerSpellIconFromSpellID(participant.spell2Id)),
                            radius: 12,
                          ),
                        ],
                      ),
                    ],
                  ),
                
                  SizedBox(width: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text('${match.gameDuration ~/ 60}m ${match.gameDuration % 60}s', style: defaultStyle.copyWith(fontSize: 12),),
                          SizedBox(width: 5,),
                          Text('${stats.totalMinionsKilled} CS', style: defaultStyle.copyWith(fontSize: 12, color: Colors.green[400]),),
                        ],
                      ),
                      SizedBox(height: 2,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('${stats.kills} / ', style: defaultStyle.copyWith(color: Colors.greenAccent),),
                          Text('${stats.deaths} / ', style: defaultStyle.copyWith(color: Colors.white),),
                          Text('${stats.assists}', style: defaultStyle.copyWith(color: Colors.orangeAccent),),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Text('$kdaRatio KDA', style: defaultStyle.copyWith(fontSize: 16, color: Theme.of(context).accentColor),),
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

                  SizedBox(width: 20,),

                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          ItemIcon(itemID: stats.item0),
                          ItemIcon(itemID: stats.item1),
                          ItemIcon(itemID: stats.item2),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          ItemIcon(itemID: stats.item3),
                          ItemIcon(itemID: stats.item4),
                          ItemIcon(itemID: stats.item5),
                        ],
                      ),
                      SizedBox(height: 5,),
                      Row(
                        children: <Widget>[
                          stats.item6 != 0 ? CircleAvatar(
                            backgroundColor: Colors.transparent,
                            backgroundImage: AssetImage(LeagueAssets.getSummonerItemIconFromID(stats.item6)),
                            radius: 12,
                            child: Container(
                              padding: EdgeInsets.fromLTRB(12, 12, 0, 0),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(5)),
                                  color: Colors.black
                                ),

                                child: Text(
                                  '${stats.visionScore}',
                                  style: defaultStyle.copyWith(fontSize: 12),
                                ),
                              ),
                            ),
                          ) : ItemIcon(itemID: 0),
                          SizedBox(width: 5,),
                          Image.asset('assets/ControlWard.png'),
                          SizedBox(width: 2,),
                          Text('${stats.visionWardsBoughtInGame}', style: defaultStyle,),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(width: 10,),

                  MatchParticipants(participants: match.participants, summonerTeamID: participant.teamId),
                ],
              ),
            )
        )
      ),
    );
  }
}