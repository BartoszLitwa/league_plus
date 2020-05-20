import 'package:flutter/material.dart';
import 'package:league_plus/screens/home/favourite_tile.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league_classes/classes.dart';

class FavouriteSummoners extends StatefulWidget {
  @override
  _FavouriteSummonersState createState() => _FavouriteSummonersState();
}

class _FavouriteSummonersState extends State<FavouriteSummoners> {
  @override
  Widget build(BuildContext context) {
    DatabaseService.favouriteCollection.document(DatabaseService.uid).snapshots().listen((event) => setState(() {}));

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
          return Text('No data');
      }
    );
  }
}