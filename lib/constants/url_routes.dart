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

  static String getApiUrl(String reg) {
    return 'https://$reg.api.riotgames.com';
  }
}

class Queues {
  static final String solo = 'RANKED_SOLO_5x5';
  static final String flexSR = 'RANKED_FLEX_SR';
  static final String flexTT = 'RANKED_FLEX_TT';
}

class SummonerUrl {
  static String getSummonerByAccount(String reg, String account) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/by-account/$account';
  }

  static String getSummonerByName(String reg, String summoner) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/by-name/$summoner';
  }

  static String getSummonerByPuuid(String reg, String puuid) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/by-puuid/$puuid';
  }

  static String getSummonerByID(String reg, String id) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/$id';
  }
}

class LeagueUrl {
  static String getChallengerLeague(String reg, String queue) {
    return '${Regions.getApiUrl(reg)}/lol/league/v4/challengerleagues/by-queue/$queue';
  }

  static String getSummonerLeagues(String reg, String summonerId) {
    return '${Regions.getApiUrl(reg)}/lol/league/v4/entries/by-summoner/$summonerId';
  }

  static String getSummonerByPuuid(String reg, String puuid) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/by-puuid/$puuid';
  }

  static String getSummonerByID(String reg, String id) {
    return '${Regions.getApiUrl(reg)}/lol/summoner/v4/summoners/$id';
  }
}

class ChampionMasteryUrl {
  static String getSummonerMastery(String reg, String summonerId) {
    return '${Regions.getApiUrl(reg)}/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId';
  }

  static String getChampionMastery(String reg, String summonerId, String championId) {
    return '${Regions.getApiUrl(reg)}/lol/champion-mastery/v4/champion-masteries/by-summoner/$summonerId/by-champion/$championId';
  }

  static String getTotalMasteryScore(String reg, String summonerId) {
    return '${Regions.getApiUrl(reg)}/lol/champion-mastery/v4/scores/by-summoner/$summonerId';
  }
  
}