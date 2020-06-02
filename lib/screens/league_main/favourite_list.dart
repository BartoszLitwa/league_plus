import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:league_plus/screens/league_main/favourite_tile.dart';
import 'package:league_plus/screens/shared/loading_circle.dart';
import 'package:league_plus/services/FireStore/database.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class FavouriteSummonersList extends StatefulWidget {
  @override
  _FavouriteSummonersListState createState() => _FavouriteSummonersListState();
}

class _FavouriteSummonersListState extends State<FavouriteSummonersList> {
  Map<int, Widget> _cache;

  @override
  void initState() {
    super.initState();
    _cache = new Map<int, Widget>();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: DatabaseService.user,
      builder: (context, snapshot) {
        return FutureBuilder<List<FavouriteSummoner>>(
          future: DatabaseService.favouriteSummoners(),
          builder: (context, AsyncSnapshot<List<FavouriteSummoner>> snapshot) {
            if(snapshot.hasData) {
              final List<FavouriteSummoner> _summoners = snapshot.data;

              return Expanded(
                child: SizedBox(
                  height: 30,
                  child: ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: _summoners.length,
                    itemBuilder: (context, index) {
                      return _getItem(index, _summoners[index]);
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

  Widget _getItem(int index, FavouriteSummoner sum) {
    if(_cache[index] != null)
      return _cache[index];
    else {
      return FutureBuilder(
        future: Future.wait([LeagueService.getSummonerBySummonerID(sum.region, sum.summonerID), LeagueService.getSummonerSoloLeague(sum.region, sum.summonerID), Future.delayed(Duration(seconds: 1))]),
        builder: (context, snapshot) {
          if(snapshot.hasData) {
            _cache[index] = FavourtieTile(sum: snapshot.data[0], soloLeague: snapshot.data[1]);
            return _cache[index];
          } else {
            return LoadingRing();
          }
        },
      );
    }
  }
}