import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:league_plus/screens/league_main/favourite_tile.dart';
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
              final List<FavouriteSummoner> summoners = snapshot.data;

              return Expanded(
                child: SizedBox(
                  height: 30,
                  child: FutureBuilder<List<Summoner>>(
                    future: LeagueService.getSummonersFromFavSumList(summoners),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return CircularProgressIndicator(backgroundColor: Theme.of(context).accentColor);
                      } else {
                        return ListView.builder(
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemCount: snapshot.data.length,
                          itemBuilder: (context, index) {
                            return _getItem(index, snapshot.data[index]);
                        });
                      }
                    }
                  ),
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

  Widget _getItem(int index, Summoner sum) {
    if(_cache[index] != null)
      return _cache[index];
    else {
      _cache[index] = FavourtieTile(sum: sum);
      return _cache[index];
    }
  }
}