import 'package:http/http.dart' as http;
import 'package:league_plus/services/league/league_helpers.dart';
import 'dart:convert';
import 'package:league_plus/services/league/url_routes.dart';
import 'package:league_plus/services/league/classes.dart';

class LeagueService {
  static final String _apiKey = 'RGAPI-ba289589-17c6-47ab-a8d2-97ff259d704b';
  static final http.Client _client = http.Client();

  static Future<dynamic> _getFromUrl(String url) async {
    try{
      var response = await _client.get(url, headers: {
        "User-Agent": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/81.0.4044.138 Safari/537.36",
        "Accept-Language": "pl-PL,pl;q=0.9,en-US;q=0.8,en;q=0.7",
        "Accept-Charset": "application/x-www-form-urlencoded; charset=UTF-8",
        "Origin": "https://developer.riotgames.com",
        "X-Riot-Token": _apiKey,
      });

      if(response == null || response.statusCode != 200)
        return null;

      return jsonDecode(response.body);
    } catch (ex) {
      print(ex.toString());
    }
  }

  static Future<Summoner> getSummonerByName(String reg, String summonerName) async {
    final response = await _getFromUrl(SummonerUrl.getSummonerByName(reg, summonerName));
    if(response == null)
      return null;
    var sum = Summoner.fromJson(response);
    sum.region = reg;
    return sum;
  }

  static Future<Summoner> getSummonerByAccountID(String reg, String accountID) async {
    var sum = Summoner.fromJson(await _getFromUrl(SummonerUrl.getSummonerByAccount(reg, accountID)));
    sum.region = reg;
    return sum;
  }

  static Future<Summoner> getSummonerBySummonerID(String reg, String summonerID) async {
    var sum = Summoner.fromJson(await _getFromUrl(SummonerUrl.getSummonerBySummonerID(reg, summonerID)));
    sum.region = reg;
    return sum;
  }

  static Future<List<Champion>> getSummonerChampions(String reg, String summonerId) async {
    var response = await _getFromUrl(ChampionMasteryUrl.getSummonerMastery(reg, summonerId));
    List<Champion> champs = (response as List).map<Champion>((c) => Champion.fromJson(c)).toList();

    return champs;
  }

  static Future<Champion> getSummonerMostMasteryChampion(String reg, String summonerId) async {
    return (await getSummonerChampions(reg, summonerId)).first;
  }

  static Future<List<League>> getSummonersLeagues(String reg, String summonerId) async {
    var response = await _getFromUrl(LeagueUrl.getSummonerLeagues(reg, summonerId));
    List<League> leagues = (response as List).map<League>((l) => League.fromJson(l)).toList();

    return leagues;
  }

  static Future<League> getSummonerSoloLeague(String reg, String summonerId) async {
    return (await getSummonersLeagues(reg, summonerId)).where((l) => l.queueType == Queues.solo).first ?? null;
  }

  static Future<League> getSummonerFlexSRLeague(String reg, String summonerId) async {
    return (await getSummonersLeagues(reg, summonerId)).where((l) => l.queueType == Queues.flexSR).first ?? null;
  }

  static Future<League> getSummonerFlexTTLeague(String reg, String summonerId) async {
    return (await getSummonersLeagues(reg, summonerId)).where((l) => l.queueType == Queues.flexTT).first ?? null;
  }

  static String getSummonerIcon(int id) {
    return 'http://ddragon.leagueoflegends.com/cdn/10.10.3208608/img/profileicon/$id.png';
  }

  static String getChampionIconFromChampionID(int championID) {
    final String champ = LeagueHelper.getChampNameByID(championID);
    return 'http://ddragon.leagueoflegends.com/cdn/10.10.3208608/img/champion/${championID != 161 ? champ.replaceAll(' ', '') : 'Velkoz'}.png';
  }

  static String getSummonerSpellIconFromSpellID(int spellID) {
    final String icon = LeagueHelper.getSummonerSpellNameByID(spellID);
    return 'http://ddragon.leagueoflegends.com/cdn/10.10.3216176/img/spell/Summoner${spellID == 14 ? 'Dot' : icon}.png';
  }

  static String summonerLeagueToAsset(String rank) {
    return 'assets/lol_ranks/Emblem_${rank.toUpperCase()}.png';
  }

  static Future<MatchListDto> getSummonerMatchList(String reg, String accountID, {int champion, int queue, int season, int endTime, int beginTime, int endIndex, int beginIndex}) async {
    var response = await _getFromUrl(MatchUrl.getMatchListByAccountID(reg, accountID));
    return response != null ? MatchListDto.fromJson(response) : null;
  }

  static Future<MatchDto> getMatchByMatchId(String reg, String matchId) async {
    var response = await _getFromUrl(MatchUrl.getMatchByMatchID(reg, matchId));
    return response != null ? MatchDto.fromJson(response) : null;
  }
}

class Regions {
  static final String br = 'br1';
  static final String eune = 'eun1';
  static final String euw = 'euw1';
  static final String jp = 'jp1';
  static final String kr = 'kr';
  static final String la1 = 'la1';
  static final String la2 = 'la2';
  static final String na = 'na1';
  static final String oc = 'oc1';
  static final String ru = 'ru';
  static final String tr = 'tr1';
}