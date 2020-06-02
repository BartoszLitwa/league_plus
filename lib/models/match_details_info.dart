import 'package:league_plus/services/league/classes.dart';

class MatchDetailsInfo {
  FavouriteSummoner sum;
  MatchDto match;
  int playerIndex;
  double kdaRatio;

  MatchDetailsInfo({this.sum, this.match, this.playerIndex, this.kdaRatio});
}