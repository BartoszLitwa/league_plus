import 'package:flutter/material.dart';
import 'package:league_plus/services/league/league_assets.dart';

class ItemIcon extends StatelessWidget {
  final int itemID;

  ItemIcon({this.itemID});

  @override
  Widget build(BuildContext context) {
    return itemID != 0 ? SizedBox(
      height: 28,
      width: 28,
      child: Image.asset(
        LeagueAssets.getSummonerItemIconFromID(itemID),
        scale: 2.3,
        repeat: ImageRepeat.noRepeat,
      ),
    ) : SizedBox(height: 28, width: 28, child: Container(decoration: BoxDecoration(color: Theme.of(context).primaryColor),),);
  }
}