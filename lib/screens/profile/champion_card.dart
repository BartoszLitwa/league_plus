import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/models/champion_card_info.dart';
import 'package:league_plus/services/league/league_assets.dart';

class ChampionCard extends StatefulWidget {
  final ChampionCardInfo champ;

  ChampionCard({this.champ});

  @override
  _ChampionCardState createState() => _ChampionCardState();
}

class _ChampionCardState extends State<ChampionCard> {
  Color _winrateColor;
  Color _kdaRatioColor;

  @override
  void initState() {
    super.initState();
    _winrateColor = widget.champ.winrate > 70 ? Colors.green[600] : widget.champ.winrate > 55 ? Colors.orange : widget.champ.winrate > 35 ? Colors.grey : Colors.redAccent;
    _kdaRatioColor = widget.champ.kdaRatio > 4 ? Colors.green[600] : widget.champ.kdaRatio > 2.5 ? Colors.orange : widget.champ.kdaRatio > 1.5 ? Colors.grey : Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(LeagueAssets.getChampionIconFromChampionID(widget.champ.championIcon)),
          ),

          SizedBox(width: 5),

          Column(
            children: <Widget>[
              Text('${widget.champ.winrate}%', style: defaultStyle.copyWith(color: _winrateColor, fontSize: 14)),
              Text('${widget.champ.kdaRatio} KDA', style: defaultStyle.copyWith(color: _kdaRatioColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}