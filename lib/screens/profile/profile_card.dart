import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/screens/profile/champion_card.dart';
import 'package:league_plus/services/league/league_api.dart';

class ProfileCard extends StatefulWidget {
  final Color white;
  final Color dark;

  ProfileCard({this.white, this.dark});

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: widget.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundColor: Colors.transparent,
                backgroundImage: NetworkImage('http://ddragon.leagueoflegends.com/cdn/10.10.3208608/img/profileicon/3587.png'),
                radius: 30,
                child: Container(
                  padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      color: widget.dark,
                    ),

                    child: Text(
                      '200',
                      style: defaultStyle.copyWith(fontSize: 14),
                    ),
                  ),
                ),
              ),

              SizedBox(width: 20,),

              Column(
                children: <Widget>[
                  Text('Synn3K', style: defaultStyle.copyWith(color: widget.dark, fontSize: 28)),

                  Row(
                    children: <Widget>[
                      CircleAvatar(
                        backgroundImage: AssetImage(LeagueService.summonerLeagueToAsset('challenger')),
                        backgroundColor: Colors.transparent,
                        radius: 8,
                      ),
                      SizedBox(width: 5),
                      
                      Text('Silver I', style: smallDarkStyle),
                      SizedBox(width: 10,),
                      Text('|', style: smallDarkStyle),
                      SizedBox(width: 10,),
                      Text('96 LP', style: smallDarkStyle),
                    ],
                  ),
                ],
              ),
            ],
          ),

          SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              ChampionCard(winrate: 63, kdaRatio: 4.13, championIcon: 266), 
              ChampionCard(winrate: 50, kdaRatio: 2.56, championIcon: 84), 
              ChampionCard(winrate: 100, kdaRatio: 3.00, championIcon: 136), 
            ],
          ),
        ],
      ),
    );
  }
}