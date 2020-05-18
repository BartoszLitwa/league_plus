import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/screens/home/favourite_tile.dart';
import 'package:league_plus/services/league_classes/classes.dart';
import 'package:provider/provider.dart';

class FavouriteSummoners extends StatefulWidget {
  final Color white;
  final Color dark;

  FavouriteSummoners({this.white, this.dark});

  @override
  _FavouriteSummonersState createState() => _FavouriteSummonersState();
}

class _FavouriteSummonersState extends State<FavouriteSummoners> {
  @override
  Widget build(BuildContext context) {
    final summoners = Provider.of<List<Summoner>>(context) ?? [];

    return Container(
      color: Colors.transparent,

      child: Column(
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Your favourites', style: defaultStyle.copyWith(fontSize: 30)),
              SizedBox(width: 10),
              Icon(Icons.star, size: 40, color: widget.white),
            ],
          ),

          SizedBox(height: 20),

          ListView.builder(
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: summoners.length,
            itemBuilder: (context, index) {
              return FavourtieTile(sum: summoners[index]);
            },
          ),
        ],
      ),
    );
  }
}