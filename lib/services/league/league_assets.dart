import 'package:league_plus/services/league/league_helpers.dart';

class LeagueAssets {
  
  static String summonerLeagueToAsset(String rank) {
    return 'assets/lol_ranks/Emblem_${rank.toUpperCase()}.png';
  }
  
  static String getSummonerIcon(int id) {
    return 'assets/lol_icons/$id.png';
  }

  static String getChampionIconFromChampionID(int championID) {
    final String champ = LeagueHelper.getChampNameByID(championID);
    String fixedChamp = champ.replaceAll(' ', '').toLowerCase();
    fixedChamp = fixedChamp[0].toUpperCase() + fixedChamp.substring(1);
    fixedChamp = championID == 21 ? 'MissFortune' : championID == 36 ? 'DrMundo' : championID == 59 ? 'JarvanIV' : championID == 64 ? 'LeeSin' :
     championID == 62 ? 'MonkeyKing' : championID == 136 ? 'AurelionSol' : championID == 5 ? 'XinZhao' : championID == 11 ? 'MasterYi' :
     championID == 4 ? 'TwistedFate' : fixedChamp;
    return 'assets/lol_champions/$fixedChamp.png';
  }

  static String getSummonerSpellIconFromSpellID(int spellID) {
    final String icon = LeagueHelper.getSummonerSpellNameByID(spellID);
    final String fixedIcon = spellID == 14 ? 'Dot' : spellID == 6 ? 'Haste' : spellID == 1 ? 'SummonerBoost' : spellID == 2 ? 'SummonerMana' : icon;
    return 'assets/lol_summoner_spells/Summoner$fixedIcon.png';
  }

  static String getRuneIconFromRuneID(int runeID) {
    final String rune = LeagueHelper.getSummonnerRuneFromID(runeID).replaceAll(' ', '');
    return 'assets/lol_perks/runes/$rune.png';
  }

  static String getSummonerItemIconFromID(int id) {
    return 'assets/lol_items/$id.png';
  }
}