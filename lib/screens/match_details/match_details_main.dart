import 'package:flutter/material.dart';
import 'package:league_plus/models/match_details_info.dart';
import 'package:league_plus/screens/shared/main_scaffold.dart';

class MatchDetails extends StatefulWidget {
  @override
  _MatchDetailsState createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  Widget build(BuildContext context) {
    final MatchDetailsInfo match = ModalRoute.of(context).settings.arguments;

    return MainScaffold(
      title: 'League of Legends',
      body: Container(
        
      )
    );
  }
}