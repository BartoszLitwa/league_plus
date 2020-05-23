import 'package:flutter/material.dart';
import 'package:league_plus/constants/styles.dart';
import 'package:league_plus/services/league/league_api.dart';

class ChampionCard extends StatefulWidget {
  final double winrate; 
  final double kdaRatio;
  final int championIcon;

  ChampionCard({this.winrate, this.kdaRatio, this.championIcon});

  @override
  _ChampionCardState createState() => _ChampionCardState();
}

class _ChampionCardState extends State<ChampionCard> {
  Color _winrateColor;
  Color _kdaRatioColor;

  @override
  void initState() {
    super.initState();
    _winrateColor = widget.winrate > 70 ? Colors.green[600] : widget.winrate > 55 ? Colors.orange : widget.winrate > 35 ? Colors.grey : Colors.redAccent;
    _kdaRatioColor = widget.kdaRatio > 4 ? Colors.green[600] : widget.kdaRatio > 2.5 ? Colors.orange : widget.kdaRatio > 1.5 ? Colors.grey : Colors.redAccent;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(LeagueService.getChampionIconFromChampionName(widget.championIcon)),
          ),

          SizedBox(width: 5),

          Column(
            children: <Widget>[
              Text('${widget.winrate}%', style: defaultStyle.copyWith(color: _winrateColor, fontSize: 14)),
              Text('${widget.kdaRatio} KDA', style: defaultStyle.copyWith(color: _kdaRatioColor, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}