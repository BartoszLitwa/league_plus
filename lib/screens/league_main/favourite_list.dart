import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:league_plus/screens/league_main/favourite_tile.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league/classes.dart';

class FavouriteSummonersList extends StatefulWidget {
  @override
  _FavouriteSummonersListState createState() => _FavouriteSummonersListState();
}

class _FavouriteSummonersListState extends State<FavouriteSummonersList> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService.user,
      builder: (context, snapshot) {
        return FutureBuilder<List<Summoner>>(
          future: DatabaseService.favouriteSummoners(),
          builder: (context, AsyncSnapshot<List<Summoner>> snapshot) {
            if(snapshot.hasData) {
              return Expanded(
                child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      return FavourtieTile(sum: snapshot.data[index]);
                  }),
                ),
              );
            }
            else
              return Text('');
          }
        );
      }
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}