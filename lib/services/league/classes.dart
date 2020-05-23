class Queues {
  static final String solo = 'RANKED_SOLO_5x5';
  static final String flexSR = 'RANKED_FLEX_SR';
  static final String flexTT = 'RANKED_FLEX_TT';
}

class Summoner {
  String id;
  String accountId;
  String puuid;
  String name;
  int profileIconId;
  int revisionDate;
  int summonerLevel;

  String region;

  Summoner({this.id, this.accountId, this.puuid, this.name, this.profileIconId, this.revisionDate, this.summonerLevel});

  Summoner.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    accountId = json['accountId'];
    puuid = json['puuid'];
    name = json['name'];
    profileIconId = json['profileIconId'];
    revisionDate = json['revisionDate'];
    summonerLevel = json['summonerLevel'];
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'accountId': accountId,
    'puuid': puuid,
    'name': name,
    'profileIconId': profileIconId,
    'revisionDate': revisionDate,
    'summonerLevel': summonerLevel,
  };
}

class FavouriteSummoner {
  String summonerID;
  String region;

  FavouriteSummoner({this.summonerID, this.region});

  FavouriteSummoner.fromJson(Map<String, dynamic> json) {
    summonerID = json['summonerID'];
    region = json['region'];
  }

  Map<String, dynamic> toJson() => {
    'summonerID': summonerID,
    'region': region,
  };
}

class Champion {
  int championPointsUntilNextLevel;
  bool chestGranted;
  int championId;
  int lastPlayTime;
  int championLevel;
  String summonerId;
  int championPoints;
  int championPointsSinceLastLevel;
  int tokensEarned;

  Champion({this.championPointsUntilNextLevel, this.chestGranted, this.championId, this.lastPlayTime, this.championLevel, this.summonerId,
            this.championPoints, this.championPointsSinceLastLevel, this.tokensEarned});

  Champion.fromJson(Map<String, dynamic> json) {
    championPointsUntilNextLevel = json['championPointsUntilNextLevel'];
    chestGranted = json['chestGranted'];
    championId = json['championId'];
    lastPlayTime = json['lastPlayTime'];
    championLevel = json['championLevel'];
    summonerId = json['summonerId'];
    championPoints = json['championPoints'];
    championPointsSinceLastLevel = json['championPointsSinceLastLevel'];
    tokensEarned = json['tokensEarned'];
  }
}

class League {
  String leagueId;
  String summonerId;
  String summonerName;
  String queueType;
  String tier;
  String rank;
  int leaguePoints;
  int wins;
  int losses;
  bool hotStreak;
  bool veteran;
  bool freshBlood;
  bool inactive;

  League.fromJson(Map<String, dynamic> json) {
    leagueId = json['leagueId'];
    summonerId = json['summonerId'];
    summonerName = json['summonerName'];
    queueType = json['queueType'];
    tier = json['tier'];
    rank = json['rank'];
    leaguePoints = json['leaguePoints'];
    wins = json['wins'];
    losses = json['losses'];
    hotStreak = json['hotStreak'];
    veteran = json['veteran'];
    freshBlood = json['freshBlood'];
    inactive = json['inactive'];
  }
}