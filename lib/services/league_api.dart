import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:league_plus/constants/url_routes.dart';
import 'package:league_plus/services/league_classes/classes.dart';

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

  static Future<Summoner> getSummoner(String reg, String summonerName) async {
    return Summoner.responseToSummoner(await _getFromUrl(SummonerUrl.getSummonerByName(reg, summonerName)));
  }

  static Future<List<Champion>> getSummonersChampion(String reg, String summonerId) async {
    var response = await _getFromUrl(ChampionMasteryUrl.getSummonerMastery(reg, summonerId));
    List<Champion> champs = (response as List).map((c) => Champion.responseToChampion(c)).toList();

    return champs;
  }

  static String getSummonerIcon(int id) {
    return 'http://ddragon.leagueoflegends.com/cdn/10.10.3208608/img/profileicon/$id.png';
  }
}