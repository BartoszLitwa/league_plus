import 'package:flutter/material.dart';
import 'package:league_plus/services/league_api.dart';
import 'package:league_plus/services/league_classes/classes.dart';

class FavourtieTile extends StatelessWidget {
  final Summoner sum;

  FavourtieTile({this.sum});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(LeagueService.getSummonerIcon(sum.profileIconId)),
          ),
          title:  Text(sum.name),
          subtitle: Row(
            children: <Widget>[
              Image.asset('assets/lol_ranks/Emblem_Gold.png'),
              Text('Gold | 1'),
            ],
          ),
        ),
      ),
    );
  }
}