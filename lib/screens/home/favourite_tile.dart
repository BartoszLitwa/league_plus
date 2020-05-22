import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/league/league_api.dart';
import 'package:league_plus/services/league/classes.dart';

class FavourtieTile extends StatelessWidget {
  final Summoner sum;

  FavourtieTile({this.sum});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: Card(
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: ListTile(
          leading: CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage(LeagueService.getSummonerIcon(sum.profileIconId)),
                radius: 25,
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 30, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: Colors.black
                    ),

                    child: Text(
                      '${sum.summonerLevel}',
                      style: defaultStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
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