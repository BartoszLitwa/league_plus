import 'dart:convert';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/local_data/file_service.dart';

class DataService {
  static List<Summoner> _summoners;

  static saveFavourites() async {
    await FileService.setStringList('favourites', _summoners.map(_toJson));
  }

  static loadFavourites() async {
    _summoners = (await FileService.getStringList('favourites')).map(_fromJson);
  }

  static _toJson(Summoner sum) {
    return json.encode(sum);
  }

  static _fromJson(String s) {
    final sum = json.decode(s);
    return Summoner(accountId: sum['accountId'], name: sum['name'], id: sum['id'], puuid: sum['puuid'],
     profileIconId: sum['profileIconId'], revisionDate: sum['revisionDate'], summonerLevel: sum['summonerLevel']);
  }
}