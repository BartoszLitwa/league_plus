import 'package:league_plus/services/helper.dart';

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

  Summoner({this.id, this.accountId, this.puuid, this.name, this.profileIconId, this.revisionDate, this.summonerLevel, this.region});

  Summoner.fromJson(Map<String, dynamic> json, {this.region}) {
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

class MatchListDto{
  int startIndex;
  int totalGames;
  int endIndex;
  List<MatchReferenceDto> matches;

  MatchListDto.fromJson(Map<String, dynamic> json) {
    startIndex = json['startIndex'];
    totalGames = json['totalGames'];
    endIndex = json['endIndex'];
    matches = (json['matches'] as List)?.map<MatchReferenceDto>((m) => MatchReferenceDto.fromJson(m))?.toList();
  }
}

class MatchReferenceDto {
  int gameId;
  String role;
  int season;
  String platformId;
  int champion;
  int queue;
  String lane;
  int timestamp;

  MatchReferenceDto.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    role = json['role'];
    season = json['season'];
    platformId = json['platformId'];
    champion = json['champion'];
    queue = json['queue'];
    lane = json['lane'];
    timestamp = json['timestamp'];
  }
}

class MatchDto {
  int gameId;
  List<ParticipantIdentityDto> participantIdentities;
  int queueId;
  String gameType;
  int gameDuration;
  List<TeamStatsDto> teams;
  String platformId;
  int gameCreation;
  int seasonId;
  String gameVersion;
  int mapId;
  String gameMode;
  List<ParticipantDto> participants;

  MatchDto.fromJson(Map<String, dynamic> json) {
    gameId = json['gameId'];
    participantIdentities = (json['participantIdentities'] as List)?.map<ParticipantIdentityDto>((e) => ParticipantIdentityDto.fromJson(e))?.toList();
    queueId = json['queueId'];
    gameType = json['gameType'];
    gameDuration = json['gameDuration'];
    teams = (json['teams'] as List)?.map<TeamStatsDto>((e) => TeamStatsDto.fromJson(e))?.toList();
    platformId = json['platformId'];
    gameCreation = json['gameCreation'];
    seasonId = json['seasonId'];
    gameVersion = json['gameVersion'];
    mapId = json['mapId'];
    gameMode = json['gameMode'];
    participants = (json['participants'] as List)?.map<ParticipantDto>((e) => ParticipantDto.fromJson(e))?.toList();
  }
}

class ParticipantIdentityDto {
  int participantId;
  PlayerDto player;

  ParticipantIdentityDto.fromJson(Map<String, dynamic> json) {
    participantId = json['participantId'];
    player = PlayerDto.fromJson(json['player']);
  }
}

class PlayerDto {
  int profileIcon;
  String accountId;
  String matchHistoryUri;
  String currentAccountId;
  String currentPlatformId;
  String summonerName;
  String summonerId;
  String platformId;

  PlayerDto.fromJson(Map<String, dynamic> json) {
    profileIcon = json['profileIcon'];
    accountId = json['accountId'];
    matchHistoryUri = json['matchHistoryUri'];
    currentAccountId = json['currentAccountId'];
    currentPlatformId = json['currentPlatformId'];
    summonerName = json['summonerName'];
    summonerId = json['summonerId'];
    platformId = json['platformId'];
  }
}

class TeamStatsDto {
  int towerKills;
  int riftHeraldKills;
  bool firstBlood;
  int inhibitorKills;
  List<TeamBansDto> bans;
  bool firstBaron;
  bool firstDragon;
  int dominionVictoryScore;
  int dragonKills;
  int baronKills;
  bool firstInhibitor;
  bool firstTower;
  int vilemawKills;
  bool firstRiftHerald;
  int teamId; // 100 for blue side. 200 for red side.
  String win;

  TeamStatsDto.fromJson(Map<String,dynamic> json) {
    towerKills = json['towerKills'];
    riftHeraldKills = json['riftHeraldKills'];
    firstBlood = json['firstBlood'];
    inhibitorKills = json['inhibitorKills'];
    bans = (json['bans'] as List)?.map<TeamBansDto>((e) => TeamBansDto.fromJson(e))?.toList();
    firstBaron = json['firstBaron'];
    firstDragon = json['firstDragon'];
    dominionVictoryScore = json['dominionVictoryScore'];
    dragonKills = json['dragonKills'];
    baronKills = json['baronKills'];
    firstInhibitor = json['firstInhibitor'];
    firstTower = json['firstTower'];
    vilemawKills = json['vilemawKills'];
    firstRiftHerald = json['firstRiftHerald'];
    teamId = json['teamId'];
    win = json['win'];
  }
}

class TeamBansDto {
  int championId;
  int pickTurn;

  TeamBansDto.fromJson(Map<String,dynamic> json) {
    championId = json['championId'];
    pickTurn = json['pickTurn'];  
  }
}

class ParticipantDto{
  int participantId;	
  int championId;
  List<RuneDto> runes;
  ParticipantStatsDto stats;
  int teamId;
  ParticipantTimelineDto timeline;
  int spell1Id;
  int spell2Id;
  String highestAchievedSeasonTier;
  List<MasteryDto> masteries;

  ParticipantDto.fromJson(Map<String,dynamic> json) {
    participantId = json['participantId'];
    championId = json['championId'];
    runes = (json['runes'] as List)?.map<RuneDto>((e) => RuneDto.fromJson(e))?.toList();
    stats = ParticipantStatsDto.fromJson(json['stats']);
    teamId = json['teamId'];
    timeline = ParticipantTimelineDto.fromJson(json['timeline']);
    spell1Id = json['spell1Id'];
    spell2Id = json['spell2Id'];
    highestAchievedSeasonTier = json['highestAchievedSeasonTier'];
    masteries =  (json['masteries'] as List)?.map<MasteryDto>((e) => MasteryDto.fromJson(e))?.toList();
  }
}

class RuneDto {
  int runeId;
  int rank;

  RuneDto.fromJson(Map<String,dynamic> json) {
    runeId = json['runeId'];
    rank = json['rank'];  
  }
}

class ParticipantStatsDto {
  int item0;
  int item1;	
  int item2;
  int item3;	
  int item4;	
  int item5;	
  int item6;	
  int totalUnitsHealed;		
  int largestMultiKill;	
  int goldEarned;	
  bool firstInhibitorKill;	
  int physicalDamageTaken;	
  int nodeNeutralizeAssist;	
  int totalPlayerScore;	
  int champLevel;	
  int damageDealtToObjectives;	
  int totalDamageTaken;	
  int neutralMinionsKilled;
  int deaths;	
  int tripleKills;
  int magicDamageDealtToChampions;	
  int wardsKilled;
  int pentaKills;
  int damageSelfMitigated;
  int largestCriticalStrike;
  int nodeNeutralize;	
  int totalTimeCrowdControlDealt;
  bool firstTowerKill;	
  int magicDamageDealt;
  int totalScoreRank;	
  int nodeCapture;	
  int wardsPlaced;	
  int totalDamageDealt;	
  int timeCCingOthers;	
  int magicalDamageTaken;	
  int largestKillingSpree;	
  int totalDamageDealtToChampions;	
  int physicalDamageDealtToChampions;	
  int neutralMinionsKilledTeamJungle;	
  int totalMinionsKilled;
  bool firstInhibitorAssist;	
  int visionWardsBoughtInGame;
  int objectivePlayerScore;
  int kills;
  bool firstTowerAssist;	
  int combatPlayerScore;	
  int inhibitorKills;
  int turretKills;
  int participantId;
  int trueDamageTaken;	
  bool firstBloodAssist	;	
  int nodeCaptureAssist;	
  int assists;
  int teamObjective;
  int altarsNeutralized;	
  int goldSpent;
  int damageDealtToTurrets;	
  int altarsCaptured;	
  bool win;		
  int totalHeal;	
  int unrealKills;
  int visionScore;	
  int physicalDamageDealt;	
  bool firstBloodKill;		
  int longestTimeSpentLiving;	
  int killingSprees;
  int sightWardsBoughtInGame;
  int trueDamageDealtToChampions;	
  int neutralMinionsKilledEnemyJungle;
  int doubleKills;
  int trueDamageDealt;	
  int quadraKills;	
  int playerScore0;	
  int playerScore1;	
  int playerScore2;	
  int playerScore3;	
  int playerScore4;	
  int playerScore5;	
  int playerScore6;	
  int playerScore7;	
  int playerScore8;	
  int playerScore9;	
  int perk0;
  int perk0Var1;
  int perk0Var2;
  int perk0Var3;	
  int perk1;
  int perk1Var1;
  int perk1Var2;
  int perk1Var3;
  int perk2;
  int perk2Var1;
  int perk2Var2;
  int perk2Var3;
  int perk3;
  int perk3Var1;
  int perk3Var2;
  int perk3Var3;
  int perk4;
  int perk4Var1;
  int perk4Var2;
  int perk4Var3;
  int perk5;
  int perk5Var1;
  int perk5Var2;
  int perk5Var3;
  int perkPrimaryStyle;
  int perkSubStyle;

  ParticipantStatsDto.fromJson(Map<String,dynamic> json) {
    item0 = json['item0'];
    item1 = json['item1'];
    item2 = json['item2'];
    item3 = json['item3'];
    item4 = json['item4'];
    item5 = json['item5'];
    item6 = json['item6'];
    totalUnitsHealed = json['totalUnitsHealed'];
    largestMultiKill = json['largestMultiKill'];
    goldEarned = json['goldEarned'];
    firstInhibitorKill = json['firstInhibitorKill'];
    physicalDamageTaken = json['physicalDamageTaken'];
    nodeNeutralizeAssist = json['nodeNeutralizeAssist'];
    totalPlayerScore = json['totalPlayerScore'];
    champLevel = json['champLevel'];
    damageDealtToObjectives = json['damageDealtToObjectives'];
    totalDamageTaken = json['totalDamageTaken'];
    neutralMinionsKilled = json['neutralMinionsKilled'];
    deaths = json['deaths'];
    tripleKills = json['tripleKills'];
    magicDamageDealtToChampions = json['magicDamageDealtToChampions'];
    wardsKilled = json['wardsKilled'];
    pentaKills = json['pentaKills'];
    damageSelfMitigated = json['damageSelfMitigated'];
    largestCriticalStrike = json['largestCriticalStrike'];
    nodeNeutralize = json['nodeNeutralize'];
    totalTimeCrowdControlDealt = json['totalTimeCrowdControlDealt'];
    firstTowerKill = json['firstTowerKill'];
    magicDamageDealt = json['magicDamageDealt'];
    totalScoreRank = json['totalScoreRank'];
    nodeCapture = json['nodeCapture'];
    wardsPlaced = json['wardsPlaced'];
    totalDamageDealt = json['totalDamageDealt'];
    timeCCingOthers = json['timeCCingOthers'];
    magicalDamageTaken = json['magicalDamageTaken'];
    largestKillingSpree = json['largestKillingSpree'];
    totalDamageDealtToChampions = json['totalDamageDealtToChampions'];
    physicalDamageDealtToChampions = json['physicalDamageDealtToChampions'];
    neutralMinionsKilledTeamJungle = json['neutralMinionsKilledTeamJungle'];
    totalMinionsKilled = json['totalMinionsKilled'];
    firstInhibitorAssist = json['firstInhibitorAssist'];
    visionWardsBoughtInGame = json['visionWardsBoughtInGame'];
    objectivePlayerScore = json['objectivePlayerScore'];
    kills = json['kills'];
    firstTowerAssist = json['firstTowerAssist'];
    combatPlayerScore = json['combatPlayerScore'];
    inhibitorKills = json['inhibitorKills'];
    turretKills = json['turretKills'];
    participantId = json['participantId'];
    trueDamageTaken = json['trueDamageTaken'];
    firstBloodAssist = json['firstBloodAssist'];
    nodeCaptureAssist = json['nodeCaptureAssist'];
    assists = json['assists'];
    teamObjective = json['teamObjective'];
    altarsNeutralized = json['altarsNeutralized'];
    goldSpent = json['goldSpent'];
    damageDealtToTurrets = json['damageDealtToTurrets'];
    altarsCaptured = json['altarsCaptured'];
    win = json['win'];
    totalHeal = json['totalHeal'];
    unrealKills = json['unrealKills'];
    visionScore = json['visionScore'];
    physicalDamageDealt = json['physicalDamageDealt'];
    firstBloodKill = json['firstBloodKill'];
    longestTimeSpentLiving = json['longestTimeSpentLiving'];
    killingSprees = json['killingSprees'];
    sightWardsBoughtInGame = json['sightWardsBoughtInGame'];
    trueDamageDealtToChampions = json['trueDamageDealtToChampions'];
    neutralMinionsKilledEnemyJungle = json['neutralMinionsKilledEnemyJungle'];
    doubleKills = json['doubleKills'];
    trueDamageDealt = json['trueDamageDealt'];
    quadraKills = json['quadraKills'];
    playerScore0 = json['playerScore0'];
    playerScore1 = json['playerScore1'];
    playerScore2 = json['playerScore2'];
    playerScore3 = json['playerScore3'];
    playerScore4 = json['playerScore4'];
    playerScore5 = json['playerScore5'];
    playerScore6 = json['playerScore6'];
    playerScore7 = json['playerScore7'];
    playerScore8 = json['playerScore8'];
    playerScore9 = json['playerScore9'];
    perk0 = json['perk0'];
    perk0Var1 = json['perk0Var1'];
    perk0Var2 = json['perk0Var2'];
    perk0Var3 = json['perk0Var3'];
    perk1 = json['perk1'];
    perk1Var1 = json['perk1Var1'];
    perk1Var2 = json['perk1Var2'];
    perk1Var3 = json['perk1Var3'];
    perk2 = json['perk2'];
    perk2Var1 = json['perk2Var1'];
    perk2Var2 = json['perk2Var2'];
    perk2Var3 = json['perk2Var3'];
    perk3 = json['perk3'];
    perk3Var1 = json['perk3Var1'];
    perk3Var2 = json['perk3Var2'];
    perk3Var3 = json['perk3Var3'];
    perk4 = json['perk4'];
    perk4Var1 = json['perk4Var1'];
    perk4Var2 = json['perk4Var2'];
    perk4Var3 = json['perk4Var3'];
    perk5 = json['perk5'];
    perk5Var1 = json['perk5Var1'];
    perk5Var2 = json['perk5Var2'];
    perk5Var3 = json['perk5Var3'];
    perkPrimaryStyle = json['perkPrimaryStyle'];
    perkSubStyle = json['perkSubStyle'];
  }
}

class ParticipantTimelineDto {
  int participantId;
  Map<String, num> csDiffPerMinDeltas;
  Map<String, num> damageTakenPerMinDeltas;
  String role;
  Map<String, num> damageTakenDiffPerMinDeltas;
  Map<String, num> xpPerMinDeltas;
  Map<String, num> xpDiffPerMinDeltas;
  String lane;
  Map<String, num> creepsPerMinDeltas;
  Map<String, num> goldPerMinDeltas;

  ParticipantTimelineDto.fromJson(Map<String,dynamic> json) {
    participantId = json['participantId'];
    csDiffPerMinDeltas = Helper.jsonToMap(json['csDiffPerMinDeltas']);
    damageTakenPerMinDeltas = Helper.jsonToMap(json['damageTakenPerMinDeltas']);
    role = json['role'];
    damageTakenDiffPerMinDeltas = Helper.jsonToMap(json['damageTakenDiffPerMinDeltas']);
    xpPerMinDeltas = Helper.jsonToMap(json['xpPerMinDeltas']);
    xpDiffPerMinDeltas = Helper.jsonToMap(json['xpDiffPerMinDeltas']);
    lane = json['lane'];
    creepsPerMinDeltas = Helper.jsonToMap(json['creepsPerMinDeltas']);
    goldPerMinDeltas = Helper.jsonToMap(json['goldPerMinDeltas']);
  }
}

class MasteryDto {
  int rank;
  int masteryId;

  MasteryDto.fromJson(Map<String, dynamic> json) {
    rank = json['rank'];
    masteryId = json['masteryId'];  
  }
}