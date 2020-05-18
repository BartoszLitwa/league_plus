import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:league_plus/models/user.dart';
import 'package:league_plus/services/league_classes/classes.dart';

class DatabaseService {
  final String uid;
  final CollectionReference favouriteCollection = Firestore.instance.collection('favourite');

  DatabaseService({this.uid});

  Stream<List<Summoner>> get summoners {
    return favouriteCollection.document(uid).snapshots().map(_summonersFromSnapshot);
  }

  Future updateUserData(Summoner summoner) async {
    return await favouriteCollection.document(uid).setData({
      'summoners': summoner.toJson(),
    }, merge: true);
  }

  // UserData from snapshot
  User _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return User(
      uid: uid,
      summoners: snapshot.data['summoners'],
    );
  }

  List<Summoner> _summonersFromSnapshot(DocumentSnapshot snapshot) {
    return List<Summoner>(snapshot.data['summoners']);
  }

  // Get user doc stream
  Stream<User> get userData {
    return favouriteCollection.document(uid).snapshots().map(_userDataFromSnapshot);
  } 

  //// Brew list from snapshot
  //List<Brew> _brewListFromSnapshot(QuerySnapshot snapshot) {
  //  return snapshot.documents.map((doc) => Brew(
  //    name: doc.data['name'] ?? '',
  //    sugars: doc.data['sugars'] ?? '0',
  //    strength: doc.data['strength'] ?? 0
  //  )).toList();
  //} 
  //
  //// Get brews stream
  //Stream<List<Brew>> get brews {
  //  return brewCollection.snapshots().map(_brewListFromSnapshot);
  //}
}