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
            backgroundImage: NetworkImage(LeagueService.getSummonerIcon(sum.profileIconId), scale: 0.1),
          ),
          title:  Text(sum.name),
          subtitle: Row(
            children: <Widget>[
              SizedBox(
                height: 20,
                child: Image.asset('assets/lol_ranks/Emblem_Gold.png'),
              ),
              Text('Gold | 1'),
            ],
          ),
        ),
      ),
    );
  }
}