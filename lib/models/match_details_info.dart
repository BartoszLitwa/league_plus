import 'package:league_plus/services/league/classes.dart';

class MatchDetailsInfo {
  final FavouriteSummoner sum;
  final MatchDto match;
  final int playerIndex;
  final double kdaRatio;
  final DateTime gameDate;
  int summonerTeamID;
  List<ParticipantDto> enemyTeam;
  List<ParticipantDto> summonerTeam;

  MatchDetailsInfo({this.sum, this.match, this.playerIndex, this.kdaRatio, this.gameDate}){
    summonerTeamID = match.participants[playerIndex].teamId;
    enemyTeam = match.participants.where((e) => e.teamId != summonerTeamID).toList();
    summonerTeam = match.participants.where((e) => e.teamId == summonerTeamID).toList();
  }
}