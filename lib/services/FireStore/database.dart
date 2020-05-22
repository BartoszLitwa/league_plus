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
    return favouriteCollection.document(uid).updateData({
      'summoners': FieldValue.arrayUnion([summoner.toJson()]),
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
    var list = _summonersFromSnapshot(await favouriteCollection.document(uid).get());
    List<Summoner> newList = [];
    if(list == null || list.isEmpty)
      return newList;

    for (var sum in list) {
      newList.add(await LeagueService.getSummonerBySummonerID(sum.region, sum.summonerID));
    }

    return newList;
  }
}