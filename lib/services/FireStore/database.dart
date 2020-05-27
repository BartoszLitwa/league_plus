import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/classes.dart';

class DatabaseService {
  static String uid;
  static final CollectionReference favouriteCollection = Firestore.instance.collection('favourite');

  static Stream<DocumentSnapshot> get user {
    return favouriteCollection.document(uid).snapshots();
  }

  static Future setUserData() async {
    await favouriteCollection.document(uid).setData({
      'userSummoner': '',
      'summoners': {},
    }, merge: false);
  }

  static Future updateUserSummoner(FavouriteSummoner summoner) async {
    await favouriteCollection.document(uid).updateData({
      'userSummoner': summoner.toJson(),
    });
  }

  static Future updateSummoners(FavouriteSummoner summoner) async {
    bool favourite = await checkIfSummonerIsFavourite(summoner);

    return favouriteCollection.document(uid).updateData({
      'summoners': favourite ? FieldValue.arrayRemove([summoner.toJson()]) : FieldValue.arrayUnion([summoner.toJson()]), 
    });
  }

  static List<FavouriteSummoner> _summonersFromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot.data == null || snapshot?.data['summoners'] == null)
     return null;

    try {
      return snapshot?.data['summoners'].map<FavouriteSummoner>((doc) {
        return FavouriteSummoner.fromJson(doc);
      }).toList();
    }catch(ex) {
      return null;
    }
  }

  static Future<List<Summoner>> favouriteSummoners() async {
    try {
      var list = _summonersFromSnapshot(await favouriteCollection.document(uid).get());
      List<Summoner> newList = [];
      if(list == null || list.isEmpty)
        return newList;

      for (var sum in list) {
        var summoner = await LeagueService.getSummonerBySummonerID(sum.region, sum.summonerID);
        summoner.region = sum.region;
        newList.add(summoner);
      }

      return newList;
    } catch(ex) {
      return null;
    }
  }

  static Future<bool> checkIfSummonerIsFavourite(FavouriteSummoner sum) async {
    try {
      var list = _summonersFromSnapshot(await favouriteCollection.document(uid).get());
      if(list == null || list.isEmpty)
        return false;

      return list.firstWhere((e) => e.region == sum.region && e.summonerID == sum.summonerID, orElse: () => null) != null;
    } catch(ex) {
      return false;
    }
  }

  static Future<FavouriteSummoner> getUserSummoner() async {
    var snapshot = await favouriteCollection.document(uid).get();

    if(snapshot.data == null || snapshot?.data['userSummoner'] == null)
      return null;

    try {
      return FavouriteSummoner.fromJson(snapshot.data['userSummoner']);
    }catch(ex) {
      return null;
    }
  }
}