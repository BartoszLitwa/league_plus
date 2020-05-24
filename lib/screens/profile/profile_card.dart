import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/screens/profile/champion_card.dart';
import 'package:league_plus/services/league/classes.dart';
import 'package:league_plus/services/league/league_api.dart';

class ProfileCard extends StatefulWidget {
  final FavouriteSummoner summoner;

  ProfileCard({this.summoner});

  @override
  _ProfileCardState createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Summoner>(
      future: LeagueService.getSummonerBySummonerID(widget.summoner.region, widget.summoner.summonerID),
      builder: (context, snapshot) {
        if(snapshot.hasData && snapshot.data != null) {
        return Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            color: Theme.of(context).accentColor,
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
                    backgroundImage: NetworkImage(LeagueService.getSummonerIcon(snapshot.data.profileIconId)),
                    radius: 30,
                    child: Container(
                      padding: EdgeInsets.fromLTRB(25, 40, 0, 0),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          color: Theme.of(context).primaryColor,
                        ),

                        child: Text(
                          snapshot.data.summonerLevel.toString(),
                          style: defaultStyle.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 20),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(snapshot.data.name, style: defaultStyle.copyWith(color: Theme.of(context).primaryColor, fontSize: 28)),

                        FutureBuilder<League>(
                          future: LeagueService.getSummonerSoloLeague(widget.summoner.region, widget.summoner.summonerID),
                          builder: (builder, snapshot) {
                            if(snapshot.hasData && snapshot.data != null) {
                              return Row(
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundImage: AssetImage(LeagueService.summonerLeagueToAsset(snapshot.data.tier)),
                                    backgroundColor: Colors.transparent,
                                    radius: 8,
                                  ),
                                  SizedBox(width: 5),
                                  
                                  Text('${snapshot.data.tier ?? 'Unranked'} ${snapshot.data.rank ?? ''}', style: smallDarkStyle),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data.tier != null ? '|' : '', style: smallDarkStyle),
                                  SizedBox(width: 10,),
                                  Text(snapshot.data.tier != null ? '${snapshot.data.leaguePoints} LP' : '', style: smallDarkStyle),
                                ],
                              );
                            } else {
                              return SpinKitRing(
                                color: Colors.white,
                                size: 50,
                              );
                            }
                          }
                        )
                          ],
                    ),
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
        } else {
          return SpinKitRing(
            color: Colors.white,
            size: 50,
          );
        }
      }
    );
  }
}