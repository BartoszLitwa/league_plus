class Summoner {
  String id;
  String accountId;
  String puuid;
  String name;
  int profileIconId;
  int revisionDate;
  int summonerLevel;

  Summoner({this.id, this.accountId, this.puuid, this.name, this.profileIconId, this.revisionDate, this.summonerLevel});

  static Summoner responseToSummoner(response) {
    return Summoner(id: response['id'], accountId: response['accountId'], puuid: response['puuid'], name: response['name'],
     profileIconId: response['profileIconId'], revisionDate: response['revisionDate'], summonerLevel: response['summonerLevel']);
  }

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

  static Champion responseToChampion(response) {
    return Champion(championPointsUntilNextLevel: response['championPointsUntilNextLevel'], chestGranted: response['chestGranted'],
      championId: response['championId'], lastPlayTime: response['lastPlayTime'], championLevel: response['championLevel'],
      summonerId: response['summonerId'], championPoints: response['championPoints'],
      championPointsSinceLastLevel: response['championPointsSinceLastLevel'], tokensEarned: response['tokensEarned']);
  }
}