import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:league_plus/services/league/url_routes.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league_plus/league_plus_web.dart';

class LeagueService {
  static final http.Client _client = http.Client();
  static String _currentVersion;
  static int index = 0;

  static Future<dynamic> _getFromUrl(String url) async {
    try{
      var response = await _client.get(url, headers: {
        "Authorization": "Bearer ${LeaguePlusWeb.bearerToken}",
      });

      if(response == null || response.statusCode != 200) {
        if(response.statusCode == 429)
          print('Rate limit exceeded!!');
        else if(response.statusCode == 401) { // Unathorized
          await LeaguePlusWeb.authenticate();
          return await _getFromUrl(url);
        } 
        else 
          print('Error while fetching data ${response.statusCode}');
        return null;
      }

      index++;
      print('Get $index');
      return jsonDecode(response.body);
    } catch (ex) {
      print(ex.toString());
    }
  }

  static Future<Summoner> getSummonerByName(String reg, String summonerName) async {
    final response = await _getFromUrl(SummonerUrl.getSummonerByName(reg, summonerName));
    if(response == null)
      return null;

    var sum = Summoner.fromJson(response, region: reg);
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

  static Future<List<Summoner>> getSummonersFromFavSumList(List<FavouriteSummoner> sums) async {
    List<Summoner> summoners = [];
    
    for(int i = 0; i < sums.length; i++) {
      var sum = await getSummonerBySummonerID(sums[i].region, sums[i].summonerID);
      if(sum != null)
        summoners.add(sum);
    }
    return summoners;
  }

  static Future<List<Champion>> getSummonerChampions(String reg, String summonerId) async {
    var response = await _getFromUrl(ChampionMasteryUrl.getSummonerMastery(reg, summonerId));
    List<Champion> champs = [];
    if(response == null)
      return champs;

    champs = (response as List).map<Champion>((c) => Champion.fromJson(c)).toList();

    return champs;
  }

  static Future<Champion> getSummonerMostMasteryChampion(String reg, String summonerId) async {
    List<Champion> champs = await getSummonerChampions(reg, summonerId);
    return champs.isNotEmpty ? champs.first : null;
  }

  static Future<List<League>> getSummonersLeagues(String reg, String summonerId) async {
    var response = await _getFromUrl(LeagueUrl.getSummonerLeagues(reg, summonerId));
    if(response == null)
      return null;

    List<League> leagues = (response as List).map<League>((l) => League.fromJson(l)).toList();

    return leagues;
  }

  static Future<League> getSummonerSoloLeague(String reg, String summonerId) async {
    var leagues = await getSummonersLeagues(reg, summonerId);
    if(leagues == null || leagues.length == 0)
      return null;

    return leagues.where((l) => l.queueType == Queues.solo)?.first ?? null;
  }

  static Future<League> getSummonerFlexSRLeague(String reg, String summonerId) async {
    var leagues = await getSummonersLeagues(reg, summonerId);
    if(leagues == null || leagues.length == 0)
      return null;

    return leagues.where((l) => l.queueType == Queues.flexSR)?.first ?? null;
  }

  static Future<League> getSummonerFlexTTLeague(String reg, String summonerId) async {
    var leagues = await getSummonersLeagues(reg, summonerId);
    if(leagues == null || leagues.length == 0)
      return null;

    return leagues.where((l) => l.queueType == Queues.flexTT)?.first ?? null;
  }

  static Future<MatchListDto> getSummonerMatchList(String reg, String accountID, {int champion, int queue, int season, int endTime, int beginTime, int endIndex, int beginIndex}) async {
    var response = await _getFromUrl(MatchUrl.getMatchListByAccountID(reg, accountID));
    return response != null ? MatchListDto.fromJson(response) : null;
  }

  static Future<MatchDto> getMatchByMatchId(String reg, String matchId) async {
    var response = await _getFromUrl(MatchUrl.getMatchByMatchID(reg, matchId));
    return response != null ? MatchDto.fromJson(response) : null;
  }

  static Future<String> updateCurrentLeagueVersion() async {
    var response = await _getFromUrl('https://leagueplusapi.azurewebsites.net/api/lol/version');

    if(response == null || response.statusCode != 200) {
      return '10.12.1';
    }

    return response.body;
  }
  
  static String getSummonerIcon(int id) {
    return 'http://ddragon.leagueoflegends.com/cdn/${_currentVersion ?? '10.12.1'}/img/profileicon/$id.png';
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