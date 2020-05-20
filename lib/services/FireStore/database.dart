import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:league_plus/services/league_classes/classes.dart';

class DatabaseService {
  static String uid;

  static final CollectionReference favouriteCollection = Firestore.instance.collection('favourite');

  static Stream<DocumentSnapshot> get user {
    return favouriteCollection.document(uid).snapshots();
  }

  static Future setUserData(Summoner summoner) async {
    await favouriteCollection.document(uid).setData({
      'summoners': {},
    }, merge: false);
  }

  static Future updateUserData(Summoner summoner) async {
    return favouriteCollection.document(uid).updateData({
      'summoners': FieldValue.arrayUnion([summoner.toJson()])
    });
  }

  static List<Summoner> _summonersFromSnapshot(DocumentSnapshot snapshot) {
    if(snapshot.data == null || snapshot?.data['summoners'] == null)
     return null;

    try {
      return snapshot?.data['summoners'].map<Summoner>((doc) {
        var map = Map<String, dynamic>.from(doc);
        return Summoner.fromJson(map);
      }).toList();
    }catch(ex) {
      return null;
    }
  }

  static Future<List<Summoner>> favouriteSummoners() async {
    return _summonersFromSnapshot(await favouriteCollection.document(uid).get());
  }
}