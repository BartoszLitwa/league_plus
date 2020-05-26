import 'package:flutter/material.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_assets.dart';

class MatchParticipants extends StatelessWidget {
  final List<ParticipantDto> participants;
  final int summonerTeamID;
  final double iconSize = 18;

  MatchParticipants({this.participants, this.summonerTeamID});

  @override
  Widget build(BuildContext context) {
    final List<ParticipantDto> enemyTeam = participants.where((e) => e.teamId != summonerTeamID).toList();
    final List<ParticipantDto> summonerTeam = participants.where((e) => e.teamId == summonerTeamID).toList();

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          SizedBox(
            height: 100,
            width: iconSize,
            child: ListView.builder(
              itemCount: summonerTeam.length,
              itemBuilder: (context, index) {
                //print('[$index] ${summonerTeam[index].championId} ${LeagueHelper.getChampNameByID(summonerTeam[index].championId)}');
                return summonerTeam[index].championId != 0 ? SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: Image.asset(
                    LeagueAssets.getChampionIconFromChampionID(summonerTeam[index].championId),
                    scale: 2,
                    repeat: ImageRepeat.noRepeat
                  ),
                ) : SizedBox(height: iconSize, width: iconSize, child: Container(decoration: BoxDecoration(color: Colors.blue[400]),),);
              },
            )
          ),

          SizedBox(width: 5,),

          SizedBox(
            height: 90,
            width: iconSize,
            child: ListView.builder(
              itemCount: enemyTeam.length,
              itemBuilder: (context, index) {
                return enemyTeam[index].championId != 0 ? SizedBox(
                  height: iconSize,
                  width: iconSize,
                  child: Image.asset(
                    LeagueAssets.getChampionIconFromChampionID(enemyTeam[index].championId),
                    scale: 3,
                    repeat: ImageRepeat.noRepeat,
                  ),
                ) : SizedBox(height: iconSize, width: iconSize, child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor),),);
              },
            ),
          ),
        ],
      ),
    );
  }
}